enum HealthRecordType {
  vaccination,
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