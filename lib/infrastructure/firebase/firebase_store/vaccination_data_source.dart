import 'package:cloud_firestore/cloud_firestore.dart';

class VaccinationDataSource {
  final FirebaseFirestore _firestore;

  VaccinationDataSource({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  /// Top-level vaccinations collection.
  CollectionReference<Map<String, dynamic>> get _vaccinationsRef =>
      _firestore.collection('vaccinations');

  // ---------------------------------------------------------------------------
  // CREATE
  // ---------------------------------------------------------------------------

  Future<void> createVaccination(
    String vaccinationId,
    Map<String, dynamic> data,
  ) async {
    await _vaccinationsRef
        .doc(vaccinationId)
        .set(data);
  }

  // ---------------------------------------------------------------------------
  // READ ALL VACCINATIONS FOR A PET
  // ---------------------------------------------------------------------------

  Future<List<Map<String, dynamic>>> getVaccinations(
    String petId,
  ) async {
    final snapshot = await _vaccinationsRef
        .where('petId', isEqualTo: petId)
        .get();

    return snapshot.docs
        .map((doc) => doc.data())
        .toList();
  }

  // ---------------------------------------------------------------------------
  // READ ONE VACCINATION
  // ---------------------------------------------------------------------------

  Future<Map<String, dynamic>?> getVaccination(
    String vaccinationId,
  ) async {
    final doc = await _vaccinationsRef
        .doc(vaccinationId)
        .get();

    if (!doc.exists) {
      return null;
    }

    return doc.data();
  }

  // ---------------------------------------------------------------------------
  // UPDATE
  // ---------------------------------------------------------------------------

  Future<void> updateVaccination(
    String vaccinationId,
    Map<String, dynamic> data,
  ) async {
    await _vaccinationsRef
        .doc(vaccinationId)
        .update(data);
  }

  // ---------------------------------------------------------------------------
  // DELETE
  // ---------------------------------------------------------------------------

  Future<void> deleteVaccination(
    String vaccinationId,
  ) async {
    await _vaccinationsRef
        .doc(vaccinationId)
        .delete();
  }

  // ---------------------------------------------------------------------------
  // COUNT VACCINATIONS FOR A PET
  // ---------------------------------------------------------------------------

  Future<int> getVaccinationCount(
    String petId,
  ) async {
    final aggregateQuery = await _vaccinationsRef
        .where('petId', isEqualTo: petId)
        .count()
        .get();

    return aggregateQuery.count ?? 0;
  }

  // ---------------------------------------------------------------------------
  // GET NEXT VACCINATION FOR A PET
  // ---------------------------------------------------------------------------

  Future<Map<String, dynamic>?> getNextVaccination(
    String petId,
  ) async {
    final snapshot = await _vaccinationsRef
        .where('petId', isEqualTo: petId)
        .where(
          'nextDueDate',
          isGreaterThanOrEqualTo: Timestamp.now(),
        )
        .orderBy('nextDueDate')
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) {
      return null;
    }

    return snapshot.docs.first.data();
  }

}