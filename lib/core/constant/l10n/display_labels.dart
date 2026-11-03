import 'package:pet_care/core/constant/l10n/app_localizations.dart';
import 'package:pet_care/features/appointments/domain/enums/appointment_types.dart';
import 'package:pet_care/features/health/domain/enums/health_record_type.dart';

// -----------------------------------------------------------------------------
// Labels for values that are STORED in English (Firestore / logic) but must be
// SHOWN translated. Never save the translated text, only display it.
// -----------------------------------------------------------------------------

/// 'Dog' | 'Cat' | 'Bird' | 'Other'  ->  translated label
String speciesLabel(AppLocalizations l10n, String value) {
  switch (value.trim().toLowerCase()) {
    case 'dog':
      return l10n.dog;
    case 'cat':
      return l10n.cat;
    case 'bird':
      return l10n.bird;
    case 'other':
      return l10n.other;
    default:
      return value; // custom value typed by the user: show as is
  }
}

/// 'Male' | 'Female'  ->  translated label
String genderLabel(AppLocalizations l10n, String value) {
  switch (value.trim().toLowerCase()) {
    case 'male':
      return l10n.male;
    case 'female':
      return l10n.female;
    default:
      return value;
  }
}

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

String healthRecordTypeLabel(AppLocalizations l10n, HealthRecordType type) {
  switch (type) {
    case HealthRecordType.checkup:
      return l10n.checkup;
    case HealthRecordType.medication:
      return l10n.medication;
    case HealthRecordType.allergy:
      return l10n.allergy;
    case HealthRecordType.surgery:
      return l10n.surgery;
    case HealthRecordType.other:
      return l10n.other;
  }
}

/// Filter chips use English keys in logic ('All', 'Vaccination', ...).
/// Keep the key, translate only the label.
String filterLabel(AppLocalizations l10n, String key) {
  switch (key.trim().toLowerCase()) {
    case 'all':
      return l10n.all;
    case 'vaccination':
      return l10n.vaccination;
    case 'checkup':
      return l10n.checkup;
    case 'medication':
      return l10n.medication;
    case 'allergy':
      return l10n.allergy;
    case 'surgery':
      return l10n.surgery;
    case 'treatment':
      return l10n.treatment;
    case 'grooming':
      return l10n.grooming;
    case 'other':
      return l10n.other;
    default:
      return key;
  }
}