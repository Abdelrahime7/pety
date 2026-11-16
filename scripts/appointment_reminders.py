from datetime import datetime, timedelta, timezone

import firebase_admin
from firebase_admin import firestore, messaging
from google.api_core.exceptions import AlreadyExists


# ---------------------------------------------------------
# Firebase initialization
# ---------------------------------------------------------

if not firebase_admin._apps:
    firebase_admin.initialize_app()

db = firestore.client()


# ---------------------------------------------------------
# Configuration
# ---------------------------------------------------------

REMINDER_BEFORE = timedelta(hours=24)
FCM_BATCH_SIZE = 500


# ---------------------------------------------------------
# Helpers
# ---------------------------------------------------------

def get_pet_name(pet_id: str) -> str:
    if not pet_id:
        return "Your pet"

    pet_doc = db.collection("pets").document(pet_id).get()

    if not pet_doc.exists:
        print(f"Pet not found: {pet_id}")
        return "Your pet"

    pet_data = pet_doc.to_dict() or {}

    return pet_data.get("name") or "Your pet"


def are_appointment_notifications_enabled(user_id: str) -> bool:
    user_doc = db.collection("users").document(user_id).get()

    if not user_doc.exists:
        print(f"User not found: {user_id}")
        return False

    user_data = user_doc.to_dict() or {}

    return user_data.get("appointmentNotificationsEnabled") is True


def get_user_fcm_tokens(user_id: str) -> list[str]:
    tokens_ref = (
        db.collection("users")
        .document(user_id)
        .collection("fcmTokens")
    )

    tokens = []

    for document in tokens_ref.stream():
        data = document.to_dict() or {}
        token = data.get("token")

        if token and token not in tokens:
            tokens.append(token)

    return tokens


# ---------------------------------------------------------
# In-app notification
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

    notification_data = {
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
    }

    try:
        # Create only once.
        # This prevents a retry from resetting isRead to false.
        notification_ref.create(notification_data)
        print(f"Notification created: {notification_id}")

    except AlreadyExists:
        print(f"Notification already exists: {notification_id}")

    return notification_id


# ---------------------------------------------------------
# FCM
# ---------------------------------------------------------

def send_fcm_notifications(
    user_id: str,
    tokens: list[str],
    appointment_id: str,
    pet_id: str,
    pet_name: str,
    appointment_type: str,
) -> tuple[int, int]:

    if not tokens:
        print("No FCM tokens found. Skipping push notification.")
        return 0, 0

    total_success = 0
    total_failure = 0

    # FCM multicast supports a maximum of 500 tokens per request.
    for start in range(0, len(tokens), FCM_BATCH_SIZE):
        batch = tokens[start:start + FCM_BATCH_SIZE]

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
            tokens=batch,
        )

        response = messaging.send_each_for_multicast(message)

        total_success += response.success_count
        total_failure += response.failure_count

        # Remove permanently invalid tokens.
        for token, send_response in zip(batch, response.responses):
            if (
                not send_response.success
                and isinstance(
                    send_response.exception,
                    messaging.UnregisteredError,
                )
            ):
                try:
                    (
                        db.collection("users")
                        .document(user_id)
                        .collection("fcmTokens")
                        .document(token)
                        .delete()
                    )

                    print("Removed an unregistered FCM token.")

                except Exception as error:
                    print(
                        f"Failed to remove an invalid token: {error}"
                    )

    print(
        f"FCM result: {total_success} successful, "
        f"{total_failure} failed."
    )

    return total_success, total_failure


# ---------------------------------------------------------
# Appointment processing
# ---------------------------------------------------------

def process_appointment(doc) -> None:

    appointment = doc.to_dict() or {}
    appointment_id = doc.id

    user_id = appointment.get("userId")
    pet_id = str(appointment.get("petId") or "")
    appointment_type = str(
        appointment.get("type") or "appointment"
    )
    appointment_date = appointment.get("date")

    # -----------------------------------------------------
    # Validate appointment
    # -----------------------------------------------------

    if not user_id or not appointment_date:
        print(f"Invalid appointment: {appointment_id}")
        return

    if appointment.get("reminder24hSent", False):
        return

    if appointment_date.tzinfo is None:
        appointment_date = appointment_date.replace(
            tzinfo=timezone.utc
        )

    now = datetime.now(timezone.utc)

    reminder_due_at = appointment_date - REMINDER_BEFORE

    if not (reminder_due_at <= now < appointment_date):
        return

    print(f"Processing appointment: {appointment_id}")

    # -----------------------------------------------------
    # Get pet information
    # -----------------------------------------------------

    pet_name = get_pet_name(pet_id)

    print(f"Pet: {pet_name}")
    print(f"Appointment type: {appointment_type}")

    # -----------------------------------------------------
    # 1. Always create in-app notification
    # -----------------------------------------------------

    notification_id = create_notification(
        appointment_id=appointment_id,
        user_id=user_id,
        pet_id=pet_id,
        pet_name=pet_name,
        appointment_type=appointment_type,
    )

    # -----------------------------------------------------
    # 2. Check push notification preference
    # -----------------------------------------------------

    push_enabled = are_appointment_notifications_enabled(user_id)

    if not push_enabled:
        print(
            f"Push notifications disabled for user: {user_id}"
        )

        # Push is intentionally disabled.
        # The in-app notification is still available.
        mark_reminder_as_sent(
            doc=doc,
            notification_id=notification_id,
        )

        return

    # -----------------------------------------------------
    # 3. Get FCM tokens
    # -----------------------------------------------------

    tokens = get_user_fcm_tokens(user_id)

    print(f"FCM tokens found: {len(tokens)}")

    # -----------------------------------------------------
    # 4. Send push notifications
    # -----------------------------------------------------

    if not tokens:
        print(
            "No FCM tokens available. "
            "In-app notification was created."
        )

        # There is nothing to send.
        # The in-app notification is still valid.
        mark_reminder_as_sent(
            doc=doc,
            notification_id=notification_id,
        )

        return

    success_count, failure_count = send_fcm_notifications(
        user_id=user_id,
        tokens=tokens,
        appointment_id=appointment_id,
        pet_id=pet_id,
        pet_name=pet_name,
        appointment_type=appointment_type,
    )

    # -----------------------------------------------------
    # 5. Mark reminder as processed
    # -----------------------------------------------------

    if success_count > 0:
        mark_reminder_as_sent(
            doc=doc,
            notification_id=notification_id,
        )

        print(f"Reminder processed: {appointment_id}")
        return

    # -----------------------------------------------------
    # FCM failed completely
    # -----------------------------------------------------

    print(
        f"FCM delivery failed for appointment "
        f"{appointment_id}: {failure_count} failed."
    )

    print(
        "Reminder will remain pending and can be retried "
        "by the next scheduled GitHub Actions run."
    )


# ---------------------------------------------------------
# Mark reminder as sent
# ---------------------------------------------------------

def mark_reminder_as_sent(
    doc,
    notification_id: str,
) -> None:

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

    print(f"Checking appointments at {now}")

    appointments = db.collection("appointments").stream()

    for doc in appointments:

        appointment = doc.to_dict() or {}

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


# ---------------------------------------------------------
# Entry point
# ---------------------------------------------------------

if __name__ == "__main__":
    main()