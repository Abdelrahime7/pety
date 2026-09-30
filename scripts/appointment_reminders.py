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
    print(f"Checking until: {reminder_limit}")

    appointments = (
        db.collection("appointments")
        .where("reminder24hSent", "==", False)
        .stream()
    )

    found = False

    for doc in appointments:
        found = True

        appointment = doc.to_dict()

        print("\nAppointment found:")
        print(f"  ID: {doc.id}")
        print(f"  Pet: {appointment.get('petId')}")
        print(f"  Type: {appointment.get('type')}")
        print(f"  Date: {appointment.get('date')}")
        print(f"  User: {appointment.get('userId')}")

    if not found:
        print("No appointments found.")


if __name__ == "__main__":
    check_appointments()