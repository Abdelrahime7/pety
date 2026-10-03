
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
# Helpers
# ---------------------------------------------------------

def get_user_fcm_tokens(user_id: str) -> list[str]:
    tokens_ref = (
        db.collection("users")
        .document(user_id)
        .collection("fcmTokens")
    )

    return [
        data.get("token")
        for document in tokens_ref.stream()
        if (data := document.to_dict()).get("token")
    ]


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


def send_fcm_notifications(
    tokens: list[str],
    appointment_id: str,
    pet_id: str,
    appointment_type: str,
) -> int:
    if not tokens:
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

    # Reminder becomes due 24 hours before the appointment.
    reminder_due_at = appointment_date - REMINDER_BEFORE

    # Do not send before the 24-hour point.
    # Do not send after the appointment.
    if not (reminder_due_at <= now < appointment_date):
        return

    notification_id = create_notification(
        appointment_id=appointment_id,
        user_id=user_id,
        pet_id=str(pet_id or ""),
        appointment_type=str(appointment_type),
    )

    tokens = get_user_fcm_tokens(user_id)

    successful_sends = send_fcm_notifications(
        tokens=tokens,
        appointment_id=appointment_id,
        pet_id=str(pet_id or ""),
        appointment_type=str(appointment_type),
    )

    # Only mark the reminder as sent when at least one
    # device successfully received the FCM request.
    if successful_sends > 0:
        doc.reference.update(
            {
                "reminder24hSent": True,
                "reminder24hSentAt": firestore.SERVER_TIMESTAMP,
                "reminder24hNotificationId": notification_id,
            }
        )


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

        if reminder_due_at <= now < appointment_date:
            process_appointment(doc)


if __name__ == "__main__":
    main()
