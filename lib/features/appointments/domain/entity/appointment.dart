import 'package:cloud_firestore/cloud_firestore.dart';

enum AppointmentStatus { upcoming, past }

class Appointment {
  final String appointmentId;
  final String petId;
  final DateTime date;
  final String veterinarian;
  final String notes;

  const Appointment({
    required this.appointmentId,
    required this.petId,
    required this.date,
    required this.veterinarian,
    this.notes = '',
  });

  String get id => appointmentId;

  DateTime get dateTime => date;

  AppointmentStatus get status =>
      date.isBefore(DateTime.now()) ? AppointmentStatus.past : AppointmentStatus.upcoming;

  Map<String, dynamic> toMap() {
    return {
      'appointmentId': appointmentId,
      'petId': petId,
      'date': Timestamp.fromDate(date),
      'veterinarian': veterinarian,
      'notes': notes,
    };
  }

  factory Appointment.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final map = doc.data() ?? {};
    final rawDate = map['date'] ?? map['dateTime'];
    final parsedDate = rawDate is Timestamp
        ? rawDate.toDate()
        : rawDate is String
            ? DateTime.tryParse(rawDate) ?? DateTime.now()
            : DateTime.now();

    return Appointment(
      appointmentId: map['appointmentId'] as String? ?? doc.id,
      petId: map['petId'] as String? ?? '',
      date: parsedDate,
      veterinarian: map['veterinarian'] as String? ?? '',
      notes: map['notes'] as String? ?? '',
    );
  }

  factory Appointment.fromMap(Map<String, dynamic> map, [String? id]) {
    final rawDate = map['date'] ?? map['dateTime'];
    final parsedDate = rawDate is Timestamp
        ? rawDate.toDate()
        : rawDate is String
            ? DateTime.tryParse(rawDate) ?? DateTime.now()
            : DateTime.now();

    return Appointment(
      appointmentId: map['appointmentId'] as String? ?? id ?? '',
      petId: map['petId'] as String? ?? '',
      date: parsedDate,
      veterinarian: map['veterinarian'] as String? ?? '',
      notes: map['notes'] as String? ?? '',
    );
  }

  Appointment copyWith({
    String? appointmentId,
    String? petId,
    DateTime? date,
    String? veterinarian,
    String? notes,
  }) {
    return Appointment(
      appointmentId: appointmentId ?? this.appointmentId,
      petId: petId ?? this.petId,
      date: date ?? this.date,
      veterinarian: veterinarian ?? this.veterinarian,
      notes: notes ?? this.notes,
    );
  }
}