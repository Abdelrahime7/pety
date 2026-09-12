import 'package:cloud_firestore/cloud_firestore.dart';

class VaccinationDataSource {
  final FirebaseFirestore _firestore;

  VaccinationDataSource({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  CollectionReference<Map<String, dynamic>> _vaccinationsRef(
    String petId,
  ) {
    return _firestore
        .collection('pets')
        .doc(petId)
        .collection('vaccinations');
  }

  // CREATE
  Future<void> createVaccination(
    String petId,
    String vaccinationId,
    Map<String, dynamic> data,
  ) async {
    await _vaccinationsRef(petId)
        .doc(vaccinationId)
        .set(data);
  }

  // READ ALL
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getVaccinations(
    String petId,
  ) async {
    final snapshot = await _vaccinationsRef(petId)
        .orderBy('vaccinationDate', descending: true)
        .get();

    return snapshot.docs;
  }

  // READ ONE
  Future<DocumentSnapshot<Map<String, dynamic>>> getVaccination(
    String petId,
    String vaccinationId,
  ) async {
    return await _vaccinationsRef(petId)
        .doc(vaccinationId)
        .get();
  }

  // UPDATE
  Future<void> updateVaccination(
    String petId,
    String vaccinationId,
    Map<String, dynamic> data,
  ) async {
    await _vaccinationsRef(petId)
        .doc(vaccinationId)
        .update(data);
  }

  // DELETE
  Future<void> deleteVaccination(
    String petId,
    String vaccinationId,
  ) async {
    await _vaccinationsRef(petId)
        .doc(vaccinationId)
        .delete();
  }
}