import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseHealthDataSource {
  final FirebaseFirestore _firestore;

  FirebaseHealthDataSource(this._firestore);

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getRecords(
    String petId,
  ) async {
    final snapshot = await _firestore
        .collection('healthRecords')
        .where('petId', isEqualTo: petId)
        .get();

    return snapshot.docs;
  }
}
