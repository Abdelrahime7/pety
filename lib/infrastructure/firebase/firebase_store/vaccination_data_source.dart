import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_care/core/constant/result/result.dart';

class VaccinationDataSource {
  final FirebaseFirestore _firestore;

  VaccinationDataSource({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  CollectionReference<Map<String, dynamic>> _collection(
    String collectionName,
  ) {
    return _firestore.collection(collectionName);
  }

  Future<void> create(
    String collectionName,
    String id,
    Map<String, dynamic> data,
  ) async {

    await _collection(collectionName).doc(id).set(data);
  }

  Future<List<Map<String, dynamic>>> getAll(
    String collectionName,
    String petId,
  ) async {
    final snapshot = await _collection(collectionName)
        .where('petId', isEqualTo: petId)
        .get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }
  Future<
    Result<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
> getAllOwnerVaccinations(
  String ownerId,
  String collectionName,
) async {
  try {
    final snapshot = await _firestore
        .collection(collectionName)
        .where('ownerId', isEqualTo: ownerId)
        .get();

    return Success(snapshot.docs);
  } on FirebaseException catch (error) {
    return Failure(
      error.message ?? 'Unable to load vaccination data.',
    );
  } catch (_) {
    return const Failure(
      'Unable to load vaccination data.',
    );
  }
}

  Future<Map<String, dynamic>?> getById(
    String collectionName,
    String id,
  ) async {
    final doc = await _collection(collectionName).doc(id).get();

    if (!doc.exists) {
      return null;
    }

    return doc.data();
  }

  Future<void> update(
    String collectionName,
    String id,
    Map<String, dynamic> data,
  ) async {
    await _collection(collectionName).doc(id).update(data);
  }

  Future<void> delete(
    String collectionName,
    String id,
  ) async {
    await _collection(collectionName).doc(id).delete();
  }

  Future<int> getCount(
    String collectionName,
    String petId,
  ) async {
    final aggregateQuery = await _collection(collectionName)
        .where('petId', isEqualTo: petId)
        .count()
        .get();

    return aggregateQuery.count ?? 0;
  }

 Future<int> getActiveSerieCount(
  String collectionName,
  String petId,
) async {
  final aggregateQuery = await _collection(collectionName)
      .where('petId', isEqualTo: petId)
      .where('isCompleted', isEqualTo: false)
      .count()
      .get();

  return aggregateQuery.count ?? 0;
}
}