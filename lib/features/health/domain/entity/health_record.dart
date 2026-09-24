import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_care/features/health/domain/enums/health_record_type.dart';

class HealthRecord {
  final String recordId;
  final String petId;
  final HealthRecordType type;
  final String title;
  final DateTime date;
  final String notes;

  const HealthRecord({
    required this.recordId,
    required this.petId,
    required this.type,
    required this.title,
    required this.date,
    required this.notes,
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
      type: healthRecordTypeFromValue(data['type']),
      title: data['title'] as String? ?? 'Health record',
      date: date,
      notes: data['notes'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'petId': petId,
      'type': type.name,
      'title': title,
      'date': Timestamp.fromDate(date),
      'notes': notes,
    };
  }

  HealthRecord copyWith({
    String? recordId,
    String? petId,
    HealthRecordType? type,
    String? title,
    DateTime? date,
    String? notes,
  }) {
    return HealthRecord(
      recordId: recordId ?? this.recordId,
      petId: petId ?? this.petId,
      type: type ?? this.type,
      title: title ?? this.title,
      date: date ?? this.date,
      notes: notes ?? this.notes,
    );
  }
}
