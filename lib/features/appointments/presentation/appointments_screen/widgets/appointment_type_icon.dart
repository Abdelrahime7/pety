
import 'package:flutter/material.dart';
import 'package:pet_care/features/appointments/domain/enums/appointment_types.dart';

IconData appointmentTypeIcon(AppointmentType type) {
  switch (type) {
    case AppointmentType.vaccination:
      return Icons.vaccines_rounded;

    case AppointmentType.checkup:
      return Icons.health_and_safety_rounded;

    case AppointmentType.treatment:
      return Icons.medication_rounded;

    case AppointmentType.surgery:
      return Icons.medical_services_rounded;

    case AppointmentType.grooming:
      return Icons.content_cut_rounded;

    case AppointmentType.other:
      return Icons.more_horiz_rounded;
  }
}