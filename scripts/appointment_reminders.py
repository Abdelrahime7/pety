from datetime import datetime, timedelta, timezone

import firebase_admin
from firebase_admin import credentials, firestore, messaging


# ---------------------------------------------------------
# Firebase initialization
# ---------------------------------------------------------

if not firebase_admin._apps:
    firebase_admin.initialize_app()

db = firestore.client()


# ---------------------------------------------------------
# Reminder configuration
# ---------------------------------------------------------

REMINDER_WINDOW_BEFORE = timedelta(
    hours=23,
    minutes=55,
)

REMINDER_WINDOW_AFTER = timedelta(
    hours=24,
    minutes=5,
)


# ---------------------------------------------------------
# Helpers
# ---------------------------------------------------------

def get_user_fcm_tokens(user_id: str) -> list[str]:
    """
    Get all FCM registration tokens belonging to the user.
    """

    tokens_ref = (
        db.collection("users")
        .document(user_id)
        .collection("fcmTokens")
    )

    documents = tokens_ref.stream()

    tokens = []

    for document in documents:
        data = document.to_dict()

        token = data.get("token")

        if token:
            tokens.append(token)

    return tokens


def create_notification(
    appointment_id: str,
    user_id: str,
    pet_id: str,
    appointment_type: str,
) -> str:
    """
    Create the persistent notification in Firestore.

    A deterministic document ID prevents duplicate
    notifications if GitHub Actions runs more than once.
    """

    notification_id = f"{appointment_id}_24h"

    notification_ref = (
        db.collection("notifications")
        .document(notification_id)
    )

    notification_ref.set(
        {
            "userId": user_id,
            "title": "Upcoming appointment",
            "body": "Your pet has an appointment tomorrow.",
            "type": "appointment",
            "isRead": False,
            "createdAt": firestore.SERVER_TIMESTAMP,
            "data": {
                "appointmentId": appointment_id,
                "petId": pet_id,
                "appointmentType": appointment_type,
            },
        },
        merge=True,
    )

    return notification_id


def send_fcm_notifications(
    tokens: list[str],
    appointment_id: str,
    pet_id: str,
    appointment_type: str,
) -> int:
    """
    Send the FCM notification to all user's devices.

    Returns the number of successful deliveries.
    """

    if not tokens:
        print("No FCM tokens found for this user.")
        return 0

    message = messaging.MulticastMessage(
        notification=messaging.Notification(
            title="Upcoming appointment",
            body="Your pet has an appointment tomorrow.",
        ),
        data={
            "type": "appointment",
            "appointmentId": appointment_id,
            "petId": pet_id,
            "appointmentType": appointment_type,
        },
        tokens=tokens,
    )

    response = messaging.send_each_for_multicast(message)

    print(
        f"FCM result: "
        f"{response.success_count} successful, "
        f"{response.failure_count} failed"
    )

    for index, send_response in enumerate(response.responses):
        if not send_response.success:
            print(
                f"FCM failed for token {tokens[index]}: "
                f"{send_response.exception}"
            )

    return response.success_count


# ---------------------------------------------------------
# Appointment processing
# ---------------------------------------------------------

def process_appointment(doc):
    appointment = doc.to_dict()

    appointment_id = doc.id

    user_id = appointment.get("userId")
    pet_id = appointment.get("petId")
    appointment_type = appointment.get(
        "type",
        "appointment",
    )

    appointment_date = appointment.get("date")

    if not user_id:
        print(
            f"Skipping {appointment_id}: "
            "missing userId"
        )
        return

    if not appointment_date:
        print(
            f"Skipping {appointment_id}: "
            "missing date"
        )
        return

    # Already processed
    if appointment.get("reminder24hSent", False):
        return

    # Firestore Timestamp -> Python datetime
    if appointment_date.tzinfo is None:
        appointment_date = appointment_date.replace(
            tzinfo=timezone.utc
        )

    now = datetime.now(timezone.utc)

    time_until_appointment = appointment_date - now

    # We only want appointments approximately 24h away.
    if not (
        REMINDER_WINDOW_BEFORE
        <= time_until_appointment
        <= REMINDER_WINDOW_AFTER
    ):
        return

    print()
    print("========================================")
    print("Appointment due for 24h reminder")
    print("========================================")
    print(f"ID: {appointment_id}")
    print(f"Pet: {pet_id}")
    print(f"Type: {appointment_type}")
    print(f"Date: {appointment_date}")
    print(f"User: {user_id}")

    # -----------------------------------------------------
    # 1. Create Firestore notification
    # -----------------------------------------------------

    notification_id = create_notification(
        appointment_id=appointment_id,
        user_id=user_id,
        pet_id=str(pet_id or ""),
        appointment_type=str(appointment_type),
    )

    print(
        f"Firestore notification created: "
        f"{notification_id}"
    )

    # -----------------------------------------------------
    # 2. Get user's FCM tokens
    # -----------------------------------------------------

    tokens = get_user_fcm_tokens(user_id)

    print(
        f"Found {len(tokens)} FCM token(s)"
    )

    # -----------------------------------------------------
    # 3. Send FCM
    # -----------------------------------------------------

    successful_sends = send_fcm_notifications(
        tokens=tokens,
        appointment_id=appointment_id,
        pet_id=str(pet_id or ""),
        appointment_type=str(appointment_type),
    )

    print(
        f"FCM successful sends: "
        f"{successful_sends}"
    )

    # -----------------------------------------------------
    # 4. Mark reminder as processed
    # -----------------------------------------------------

    doc.reference.update(
        {
            "reminder24hSent": True,
            "reminder24hSentAt": firestore.SERVER_TIMESTAMP,
            "reminder24hNotificationId": notification_id,
        }
    )

    print("Appointment marked as reminded.")


# ---------------------------------------------------------
# Main
# ---------------------------------------------------------

def main():

    now = datetime.now(timezone.utc)

    reminder_start = (
        now + REMINDER_WINDOW_BEFORE
    )

    reminder_end = (
        now + REMINDER_WINDOW_AFTER
    )

    print(
        f"Current time: {now}"
    )

    print(
        f"Checking appointments between:"
    )

    print(
        f"  {reminder_start}"
    )

    print(
        f"  {reminder_end}"
    )

    # -----------------------------------------------------
    # Get appointments
    # -----------------------------------------------------

    appointments_ref = db.collection(
        "appointments"
    )

    documents = appointments_ref.stream()

    found = 0

    for doc in documents:

        appointment = doc.to_dict()

        if appointment.get(
            "reminder24hSent",
            False,
        ):
            continue

        appointment_date = appointment.get(
            "date"
        )

        if not appointment_date:
            continue

        if appointment_date.tzinfo is None:
            appointment_date = appointment_date.replace(
                tzinfo=timezone.utc
            )

        if (
            reminder_start
            <= appointment_date
            <= reminder_end
        ):
            found += 1

            process_appointment(doc)

    print()

    print(
        f"Appointments requiring reminder: "
        f"{found}"
    )


if __name__ == "__main__":
    main()