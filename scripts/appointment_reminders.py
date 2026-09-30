import os
from datetime import datetime, timedelta, timezone

import firebase_admin
from firebase_admin import credentials, firestore


service_account = os.environ["GOOGLE_APPLICATION_CREDENTIALS"]

cred = credentials.Certificate(service_account)
firebase_admin.initialize_app(cred)

db = firestore.client()


def check_appointments():
    now = datetime.now(timezone.utc)
    reminder_limit = now + timedelta(hours=24)

    print(f"Current time: {now}")
    print(f"Checking appointments until: {reminder_limit}")

    appointments = (
        db.collection("appointments")
        .where(filter=firestore.FieldFilter(
            field_path="reminder24hSent",
            op_string="==",
            value=False,
        ))
        .stream()
    )

    found = False

    for doc in appointments:
        appointment = doc.to_dict()
        appointment_date = appointment.get("date")

        if not appointment_date:
            continue

        # Firestore Timestamp normally becomes a datetime object.
        if appointment_date.tzinfo is None:
            appointment_date = appointment_date.replace(tzinfo=timezone.utc)

        if now < appointment_date <= reminder_limit:
            found = True

            print("\nAppointment due for 24h reminder:")
            print(f"  ID: {doc.id}")
            print(f"  Pet: {appointment.get('petId')}")
            print(f"  Type: {appointment.get('type')}")
            print(f"  Date: {appointment_date}")
            print(f"  User: {appointment.get('userId')}")

    if not found:
        print("No appointments due for a 24h reminder.")


if __name__ == "__main__":
    check_appointments()