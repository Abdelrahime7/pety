import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_care/features/health/domain/entity/health_item_entity.dart';
import 'package:pet_care/features/health/domain/enums/health_item.dart';
import 'package:pet_care/features/health/domain/enums/health_record_type.dart';

class HealthRecord extends HealthItem {
  final String recordId;
  final String petId;
  final HealthRecordType recordType;
  final String title;
  final String notes;
  final String veterinarian;

  @override
  final HealthItemType type = HealthItemType.health;

  @override
  final DateTime date;

  HealthRecord({
    required this.recordId,
    required this.petId,
    required this.recordType,
    required this.title,
    required this.date,
    required this.notes,
    required this.veterinarian,
  });

  factory HealthRecord.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data() ?? {};

    final rawDate = data['date'];

    final date = rawDate is Timestamp
        ? rawDate.toDate()
        : rawDate is String
            ? DateTime.tryParse(rawDate) ?? DateTime.now()
            : DateTime.now();

    return HealthRecord(
      recordId: doc.id,
      petId: data['petId'] as String? ?? '',
      recordType: healthRecordTypeFromValue(data['type']),
      title: data['title'] as String? ?? 'Health record',
      date: date,
      notes: data['notes'] as String? ?? '',
      veterinarian: data['veterinarian'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'petId': petId,
      'type': recordType.name,
      'title': title,
      'date': Timestamp.fromDate(date),
      'notes': notes,
      'veterinarian': veterinarian,
    };
  }

  HealthRecord copyWith({
    String? recordId,
    String? petId,
    HealthRecordType? recordType,
    String? title,
    DateTime? date,
    String? notes,
    String? veterinarian,
  }) {
    return HealthRecord(
      recordId: recordId ?? this.recordId,
      petId: petId ?? this.petId,
      recordType: recordType ?? this.recordType,
      title: title ?? this.title,
      date: date ?? this.date,
      notes: notes ?? this.notes,
      veterinarian: veterinarian ?? this.veterinarian,
    );
  }
}