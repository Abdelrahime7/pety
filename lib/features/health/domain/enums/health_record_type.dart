import 'package:flutter/material.dart';

enum HealthRecordType {
  checkup,
  medication,
  allergy,
  surgery,
  other,
}

HealthRecordType healthRecordTypeFromValue(Object? value) {
  final normalized = value?.toString().toLowerCase();
  return HealthRecordType.values.firstWhere(
    (type) => type.name == normalized,
    orElse: () => HealthRecordType.other,
  );
}

extension HealthRecordTypeX on HealthRecordType {
  String get displayName => switch (this) {
        HealthRecordType.checkup => 'Checkup',
        HealthRecordType.medication => 'Medication',
        HealthRecordType.allergy => 'Allergy',
        HealthRecordType.surgery => 'Surgery',
        HealthRecordType.other => 'Other',
      };

  Color get color => switch (this) {
        HealthRecordType.checkup => const Color(0xFF0284C7),
        HealthRecordType.medication => const Color(0xFFEA580C),
        HealthRecordType.allergy => const Color(0xFFEF4444),
        HealthRecordType.surgery => const Color(0xFF8B5CF6),
        HealthRecordType.other => const Color(0xFF64748B),
      };

  Color get backgroundColor => switch (this) {
        HealthRecordType.checkup => const Color(0xFFE0F2FE),
        HealthRecordType.medication => const Color(0xFFFFF7ED),
        HealthRecordType.allergy => const Color(0xFFFEF2F2),
        HealthRecordType.surgery => const Color(0xFFF5F3FF),
        HealthRecordType.other => const Color(0xFFF1F5F9),
      };

  IconData get icon => switch (this) {
        HealthRecordType.checkup => Icons.medical_services_outlined,
        HealthRecordType.medication => Icons.medication_outlined,
        HealthRecordType.allergy => Icons.warning_amber_rounded,
        HealthRecordType.surgery => Icons.content_cut_rounded,
        HealthRecordType.other => Icons.badge_outlined,
      };
}