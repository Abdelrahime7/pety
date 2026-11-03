
import 'package:pet_care/core/constant/l10n/app_localizations.dart';
import 'package:pet_care/features/appointments/domain/enums/appointment_types.dart';

String appointmentTypeLabel(AppLocalizations l10n, AppointmentType type) {
  switch (type) {
    case AppointmentType.vaccination:
      return l10n.vaccination;
    case AppointmentType.checkup:
      return l10n.checkup;
    case AppointmentType.treatment:
      return l10n.treatment;
    case AppointmentType.surgery:
      return l10n.surgery;
    case AppointmentType.grooming:
      return l10n.grooming;
    case AppointmentType.other:
      return l10n.other;
  }
}
