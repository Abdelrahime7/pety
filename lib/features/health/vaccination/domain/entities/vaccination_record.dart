import 'package:cloud_firestore/cloud_firestore.dart';

class VaccinationRecord {
  final String? id;

  final String petId;

  /// Groups doses that belong to the same vaccination series.
  final String? seriesId;

  final String vaccineName;

  /// Current dose number in the series.
  final int doseNumber;


  /// Date this dose was actually administered.
  final DateTime vaccinationDate;

  final String? notes;

  VaccinationRecord({
    required this.id,
    required this.petId,
    this.seriesId,
    required this.vaccineName,
    required this.doseNumber,
    required this.vaccinationDate,
    this.notes,
  });

  factory VaccinationRecord.fromMap(Map<String, dynamic> data) {
    return VaccinationRecord(
      id: data['id'] as String?,
      petId: data['petId'] as String,
      seriesId: data['seriesId'] as String?,
      vaccineName: data['vaccineName'] as String,
      doseNumber: data['doseNumber'] as int,
      vaccinationDate:
          (data['vaccinationDate'] as Timestamp).toDate(),
      notes: data['notes'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'petId': petId,
      'seriesId': seriesId,
      'vaccineName': vaccineName,
      'doseNumber': doseNumber,
      'vaccinationDate': Timestamp.fromDate(vaccinationDate),
      'notes': notes,
    };
  }

}