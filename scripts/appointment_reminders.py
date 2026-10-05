from datetime import datetime, timedelta, timezone

import firebase_admin
from firebase_admin import firestore, messaging


# ---------------------------------------------------------
# Firebase initialization
# ---------------------------------------------------------

if not firebase_admin._apps:
    firebase_admin.initialize_app()

db = firestore.client()


# ---------------------------------------------------------
# Reminder configuration
# ---------------------------------------------------------

REMINDER_BEFORE = timedelta(hours=24)


# ---------------------------------------------------------
# Pet
# ---------------------------------------------------------

def get_pet_name(pet_id: str) -> str:
    if not pet_id:
        return "Your pet"

    pet_ref = db.collection("pets").document(pet_id)
    pet_doc = pet_ref.get()

    if not pet_doc.exists:
        print(f"Pet not found: {pet_id}")
        return "Your pet"

    pet_data = pet_doc.to_dict()

    return pet_data.get("name") or "Your pet"


# ---------------------------------------------------------
# FCM tokens
# ---------------------------------------------------------

def get_user_fcm_tokens(user_id: str) -> list[str]:
    tokens_ref = (
        db.collection("users")
        .document(user_id)
        .collection("fcmTokens")
    )

    tokens = []

    for document in tokens_ref.stream():
        data = document.to_dict()
        token = data.get("token")

        if token:
            tokens.append(token)

    return tokens


# ---------------------------------------------------------
# Firestore notification
# ---------------------------------------------------------

def create_notification(
    appointment_id: str,
    user_id: str,
    pet_id: str,
    pet_name: str,
    appointment_type: str,
) -> str:

    notification_id = f"{appointment_id}_24h"

    notification_ref = (
        db.collection("notifications")
        .document(notification_id)
    )

    notification_ref.set(
        {
            "userId": user_id,
            "title": f"Upcoming appointment for {pet_name}",
            "body": (
                f"{pet_name} has a "
                f"{appointment_type} appointment tomorrow."
            ),
            "type": "appointment",
            "isRead": False,
            "createdAt": firestore.SERVER_TIMESTAMP,
            "data": {
                "appointmentId": appointment_id,
                "petId": pet_id,
                "petName": pet_name,
                "appointmentType": appointment_type,
            },
        },
        merge=True,
    )

    return notification_id


# ---------------------------------------------------------
# FCM
# ---------------------------------------------------------

def send_fcm_notifications(
    tokens: list[str],
    appointment_id: str,
    pet_id: str,
    pet_name: str,
    appointment_type: str,
) -> int:

    # FCM is optional.
    # No token means no Android push,
    # but the Firestore notification still exists.

    if not tokens:
        print(
            "No FCM tokens found. "
            "Skipping Android push notification."
        )
        return 0

    message = messaging.MulticastMessage(
        notification=messaging.Notification(
            title=f"Upcoming appointment for {pet_name}",
            body=(
                f"{pet_name} has a "
                f"{appointment_type} appointment tomorrow."
            ),
        ),
        data={
            "type": "appointment",
            "appointmentId": appointment_id,
            "petId": pet_id,
            "petName": pet_name,
            "appointmentType": appointment_type,
        },
        tokens=tokens,
    )

    response = messaging.send_each_for_multicast(message)

    print(
        f"FCM: {response.success_count} successful, "
        f"{response.failure_count} failed"
    )

    return response.success_count


# ---------------------------------------------------------
# Appointment processing
# ---------------------------------------------------------

def process_appointment(doc) -> None:

    appointment = doc.to_dict()
    appointment_id = doc.id

    user_id = appointment.get("userId")
    pet_id = appointment.get("petId")
    appointment_type = appointment.get(
        "type",
        "appointment",
    )
    appointment_date = appointment.get("date")

    # -----------------------------------------------------
    # Validate appointment
    # -----------------------------------------------------

    if not user_id or not appointment_date:
        return

    # Already processed
    if appointment.get("reminder24hSent", False):
        return

    # Firestore timestamps should normally already be
    # timezone-aware, but handle naive timestamps safely.
    if appointment_date.tzinfo is None:
        appointment_date = appointment_date.replace(
            tzinfo=timezone.utc
        )

    now = datetime.now(timezone.utc)

    # Reminder becomes due 24 hours before appointment.
    reminder_due_at = appointment_date - REMINDER_BEFORE

    # Only process appointments whose reminder is currently due.
    if not (reminder_due_at <= now < appointment_date):
        return

    print(
        f"Processing appointment: {appointment_id}"
    )

    # -----------------------------------------------------
    # Get pet
    # -----------------------------------------------------

    pet_id = str(pet_id or "")
    pet_name = get_pet_name(pet_id)
    appointment_type = str(appointment_type)

    print(f"Pet: {pet_name}")
    print(f"Appointment type: {appointment_type}")

    # -----------------------------------------------------
    # 1. ALWAYS create Firestore notification
    # -----------------------------------------------------

    notification_id = create_notification(
        appointment_id=appointment_id,
        user_id=user_id,
        pet_id=pet_id,
        pet_name=pet_name,
        appointment_type=appointment_type,
    )

    print(
        f"Firestore notification created: "
        f"{notification_id}"
    )

    # -----------------------------------------------------
    # 2. Get FCM tokens
    # -----------------------------------------------------

    tokens = get_user_fcm_tokens(user_id)

    print(
        f"FCM tokens found: {len(tokens)}"
    )

    # -----------------------------------------------------
    # 3. Send FCM if tokens exist
    # -----------------------------------------------------

    send_fcm_notifications(
        tokens=tokens,
        appointment_id=appointment_id,
        pet_id=pet_id,
        pet_name=pet_name,
        appointment_type=appointment_type,
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

    print(
        "Reminder marked as processed."
    )


# ---------------------------------------------------------
# Main
# ---------------------------------------------------------

def main():

    now = datetime.now(timezone.utc)

    print(
        f"Checking appointments at {now}"
    )

    appointments = (
        db.collection("appointments")
        .stream()
    )

    for doc in appointments:

        appointment = doc.to_dict()

        # Skip already processed reminders.
        if appointment.get(
            "reminder24hSent",
            False,
        ):
            continue

        appointment_date = appointment.get("date")

        if not appointment_date:
            continue

        if appointment_date.tzinfo is None:
            appointment_date = appointment_date.replace(
                tzinfo=timezone.utc
            )

        reminder_due_at = (
            appointment_date - REMINDER_BEFORE
        )

        print(
            f"Appointment {doc.id}: "
            f"date={appointment_date}, "
            f"reminder_due_at={reminder_due_at}, "
            f"now={now}"
        )

        if reminder_due_at <= now < appointment_date:
            process_appointment(doc)


# ---------------------------------------------------------
# Entry point
# ---------------------------------------------------------

if __name__ == "__main__":
    main()