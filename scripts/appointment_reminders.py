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


# ---------------------------------------------------------
# FCM
# ---------------------------------------------------------

def send_fcm_notifications(
    tokens: list[str],
    appointment_id: str,
    pet_id: str,
    appointment_type: str,
) -> int:

    if not tokens:
        print("No FCM tokens found.")
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
    appointment_type = appointment.get("type", "appointment")
    appointment_date = appointment.get("date")

    if not user_id or not appointment_date:
        return

    if appointment.get("reminder24hSent", False):
        return

    if appointment_date.tzinfo is None:
        appointment_date = appointment_date.replace(
            tzinfo=timezone.utc
        )

    now = datetime.now(timezone.utc)

    # Reminder becomes due 24 hours before appointment.
    reminder_due_at = appointment_date - REMINDER_BEFORE

    # Only process appointments whose reminder is due.
    if not (reminder_due_at <= now < appointment_date):
        return

    print(f"Processing appointment: {appointment_id}")

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
        f"Firestore notification created: {notification_id}"
    )

    # -----------------------------------------------------
    # 2. Get FCM tokens
    # -----------------------------------------------------

    tokens = get_user_fcm_tokens(user_id)

    print(f"FCM tokens found: {len(tokens)}")

    # -----------------------------------------------------
    # 3. Send FCM notification
    # -----------------------------------------------------

    successful_sends = send_fcm_notifications(
        tokens=tokens,
        appointment_id=appointment_id,
        pet_id=str(pet_id or ""),
        appointment_type=str(appointment_type),
    )

    # -----------------------------------------------------
    # 4. Mark reminder as sent
    # -----------------------------------------------------

    if successful_sends > 0:

        doc.reference.update(
            {
                "reminder24hSent": True,
                "reminder24hSentAt": firestore.SERVER_TIMESTAMP,
                "reminder24hNotificationId": notification_id,
            }
        )

        print("Reminder marked as sent.")


# ---------------------------------------------------------
# Main
# ---------------------------------------------------------

def main():

    now = datetime.now(timezone.utc)

    appointments = db.collection("appointments").stream()

    for doc in appointments:

        appointment = doc.to_dict()

        if appointment.get("reminder24hSent", False):
            continue

        appointment_date = appointment.get("date")

        if not appointment_date:
            continue

        if appointment_date.tzinfo is None:
            appointment_date = appointment_date.replace(
                tzinfo=timezone.utc
            )

        reminder_due_at = appointment_date - REMINDER_BEFORE

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