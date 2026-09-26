import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:pet_care/features/appointments/domain/enums/appointment_types.dart';

enum AppointmentStatus { upcoming, past }

class Appointment {
  final String appointmentId;
  final String petId;
  final DateTime date;
  final String veterinarian;
  final String notes;
  final AppointmentType type;

  const Appointment({
    required this.appointmentId,
    required this.petId,
    required this.date,
    required this.veterinarian,
    this.notes = '',
    required this.type,
  });

  String get id => appointmentId;

  DateTime get dateTime => date;

  AppointmentStatus get status =>
      date.isBefore(DateTime.now())
          ? AppointmentStatus.past
          : AppointmentStatus.upcoming;

  Map<String, dynamic> toMap() {
    return {
      'appointmentId': appointmentId,
      'petId': petId,
      'date': Timestamp.fromDate(date),
      'veterinarian': veterinarian,
      'notes': notes,
      'type': type.name,
    };
  }

  factory Appointment.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final map = doc.data() ?? {};

    return Appointment.fromMap(map, doc.id);
  }

  factory Appointment.fromMap(
    Map<String, dynamic> map, [
    String? id,
  ]) {
    final rawDate = map['date'] ?? map['dateTime'];

    final parsedDate = rawDate is Timestamp
        ? rawDate.toDate()
        : rawDate is String
            ? DateTime.tryParse(rawDate) ?? DateTime.now()
            : DateTime.now();

    final rawType = map['type'] as String?;

    final type = AppointmentType.values.firstWhere(
      (value) => value.name == rawType,
      orElse: () => AppointmentType.other,
    );

    return Appointment(
      appointmentId: map['appointmentId'] as String? ?? id ?? '',
      petId: map['petId'] as String? ?? '',
      date: parsedDate,
      veterinarian: map['veterinarian'] as String? ?? '',
      notes: map['notes'] as String? ?? '',
      type: type,
    );
  }

  Appointment copyWith({
    String? appointmentId,
    String? petId,
    DateTime? date,
    String? veterinarian,
    String? notes,
    AppointmentType? type,
  }) {
    return Appointment(
      appointmentId: appointmentId ?? this.appointmentId,
      petId: petId ?? this.petId,
      date: date ?? this.date,
      veterinarian: veterinarian ?? this.veterinarian,
      notes: notes ?? this.notes,
      type: type ?? this.type,
    );
  }
}
