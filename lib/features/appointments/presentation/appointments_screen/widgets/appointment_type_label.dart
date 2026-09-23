import 'package:pet_care/features/appointments/domain/enums/appointment_types.dart';

String appointmentTypeLabel(AppointmentType type) {
  switch (type) {
    case AppointmentType.vaccination:
      return 'Vaccination';

    case AppointmentType.checkup:
      return 'Checkup';

    case AppointmentType.treatment:
      return 'Treatment';

    case AppointmentType.surgery:
      return 'Surgery';

    case AppointmentType.grooming:
      return 'Grooming';

    case AppointmentType.other:
      return 'Other';
  }
}

