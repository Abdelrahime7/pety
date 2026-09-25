import 'package:cloud_firestore/cloud_firestore.dart';

class VaccinationSerie {
  final String? id;

  /// Pet this vaccination series belongs to.
  final String petId;

  /// Name of the vaccine used in this series.
  final String vaccineName;

  /// Total number of doses required to complete the series.
  final int requiredDoses;
  final int completedDoses ;
  final bool isCompleted;

  /// Optional description of the vaccination series.
  final String? description;

  /// Date the series was created.
  final DateTime createdAt;

  VaccinationSerie({
    required this.id,
    required this.petId,
    required this.vaccineName,
    required this.requiredDoses,
    required this.completedDoses,
    required this.isCompleted, 
    this.description,
    required this.createdAt,
  });

  factory VaccinationSerie.fromMap(Map<String, dynamic> data) {
    return VaccinationSerie(
      id: data['id'] as String?,
      petId: data['petId'] as String,
      vaccineName: data['vaccineName'] as String,
      requiredDoses: data['requiredDoses'] as int,
      completedDoses:data['completedDoses'] as int ,
      isCompleted: data['isCompleted'] as bool,
      description: data['description'] as String?,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'petId': petId,
      'vaccineName': vaccineName,
      'requiredDoses': requiredDoses,
      'completedDoses':completedDoses,
      'isCompleted':isCompleted,
      'description': description,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }


VaccinationSerie copyWith({
  String? id,
  String? petId,
  String? vaccineName,
  int? requiredDoses,
  int? completedDoses,
  bool? isCompleted,
  String? description,
  DateTime? createdAt,
}) {
  return VaccinationSerie(
    id: id ?? this.id,
    petId: petId ?? this.petId,
    vaccineName: vaccineName ?? this.vaccineName,
    requiredDoses: requiredDoses ?? this.requiredDoses,
    completedDoses: completedDoses ?? this.completedDoses,
    isCompleted: isCompleted??this.isCompleted,
    description: description ?? this.description,
    createdAt: createdAt ?? this.createdAt,
  );
}


}

