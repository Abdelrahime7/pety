import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_care/features/appointments/domain/entity/appointment.dart';

class AppointmentFirestoreDataSource {
  final FirebaseFirestore _firestore;

  AppointmentFirestoreDataSource(this._firestore);

  Future<void> addAppointment(Appointment appointment) async {
    await _firestore
        .collection('appointments')
        .doc(appointment.appointmentId)
        .set(appointment.toMap());
  }

  /// Fetches appointments for a list of pet IDs.
  /// Automatically chunks queries into batches of 30 to comply with Firestore whereIn limits.
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getAppointmentsForPets(List<String> petIds) async {
    if (petIds.isEmpty) return [];

    final List<QueryDocumentSnapshot<Map<String, dynamic>>> allDocs = [];
    const chunkSize = 30;

    for (var i = 0; i < petIds.length; i += chunkSize) {
      final end = (i + chunkSize < petIds.length) ? i + chunkSize : petIds.length;
      final chunk = petIds.sublist(i, end);

      final snapshot = await _firestore
          .collection('appointments')
          .where('petId', whereIn: chunk)
          .get();

      allDocs.addAll(snapshot.docs);
    }

    return allDocs;
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getAppointmentsForPet(String petId) async {
    final snapshot = await _firestore
        .collection('appointments')
        .where('petId', isEqualTo: petId)
        .orderBy('date')
        .get();

    return snapshot.docs;
  }

  /// Legacy query by ownerId if stored
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getAppointments(
    String ownerId,
  ) async {
    final snapshot = await _firestore
        .collection('appointments')
        .where('ownerId', isEqualTo: ownerId)
        .get();

    return snapshot.docs;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getAppointment(
    String appointmentId,
  ) async {
    return await _firestore
        .collection('appointments')
        .doc(appointmentId)
        .get();
  }

  Future<void> updateAppointment(
    String appointmentId,
    Map<String, dynamic> data,
  ) async {
    await _firestore
        .collection('appointments')
        .doc(appointmentId)
        .update(data);
  }

  Future<void> deleteAppointment(String appointmentId) async {
    await _firestore
        .collection('appointments')
        .doc(appointmentId)
        .delete();
  }
}