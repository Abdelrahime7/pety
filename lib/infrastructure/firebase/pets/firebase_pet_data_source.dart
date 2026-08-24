import 'package:cloud_firestore/cloud_firestore.dart';

class PetFirestoreDataSource {
  final FirebaseFirestore _firestore;

  PetFirestoreDataSource(this._firestore);

  Future<void> addPet(Map<String, dynamic> petData) async {
    try {
      await _firestore.collection('pets').add(petData);
    } catch (e) {
      throw Exception("Failed to add pet: $e");
    }
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getPets(String ownerId) async {
    try {
      final snapshot = await _firestore
          .collection('pets')
          .where('ownerId', isEqualTo: ownerId)
          .get();
      return snapshot.docs;
    } catch (e) {
      throw Exception("Failed to fetch pets: $e");
    }
  }
}
