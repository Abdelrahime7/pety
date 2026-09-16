import 'package:pet_care/features/health/vaccination/domain/enums/vaccinaton_status.dart';

extension VaccinationStatusExtension on VaccinationDueStatus {
  String get displayName {
    switch (this) {
      case VaccinationDueStatus.unscheduled:
        return 'Not scheduled';
      case VaccinationDueStatus.upcoming:
        return 'Upcoming';
      case VaccinationDueStatus.dueToday:
        return 'Due today';
      case VaccinationDueStatus.overdue:
        return 'Overdue';
    }
  }
}