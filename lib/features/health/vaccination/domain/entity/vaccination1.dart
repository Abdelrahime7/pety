
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_care/features/health/vaccination/domain/enums/vaccinaton_status.dart';

class Vaccination {
  final String? id;
  final String petId;
  final String vaccineName;
  final DateTime vaccinationDate;
  final DateTime? nextDueDate;
  final String? nextVaccineName;
  final String? notes;

  Vaccination({
    required this.id,
    required this.petId,
    required this.vaccineName,
    required this.vaccinationDate,
    this.nextDueDate,
    this.nextVaccineName,
    this.notes,
  });

  factory Vaccination.fromMap(Map<String, dynamic> data) {
    return Vaccination(
      id: data['id'] as String?,
      petId: data['petId'] as String,
      vaccineName: data['vaccineName'] as String,
      vaccinationDate:
          (data['vaccinationDate'] as Timestamp).toDate(),
      nextDueDate: data['nextDueDate'] != null
          ? (data['nextDueDate'] as Timestamp).toDate()
          : null,
      nextVaccineName: data['nextVaccineName'] as String?,
      notes: data['notes'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'petId': petId,
      'vaccineName': vaccineName,
      'vaccinationDate': Timestamp.fromDate(vaccinationDate),
      'nextDueDate': nextDueDate != null
          ? Timestamp.fromDate(nextDueDate!)
          : null,
      'nextVaccineName': nextVaccineName,
      'notes': notes,
    };
  }


VaccinationDueStatus  get duestatus {
  if (nextDueDate == null) {
    return VaccinationDueStatus.unscheduled;
  }

  final now = DateTime.now();

  final today = DateTime(now.year, now.month, now.day);
  final dueDate = DateTime(
    nextDueDate!.year,
    nextDueDate!.month,
    nextDueDate!.day,
  );

  if (dueDate.isBefore(today)) {
    return VaccinationDueStatus.overdue;
  }

  if (dueDate.isAtSameMomentAs(today)) {
    return VaccinationDueStatus.dueToday;
  }

  return VaccinationDueStatus.upcoming;
}
}
