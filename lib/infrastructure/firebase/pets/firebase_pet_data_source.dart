import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_care/features/pets/domain/entity/pet.dart';

class PetFirestoreDataSource {
  final FirebaseFirestore _firestore;

  PetFirestoreDataSource(this._firestore);

  Future<void> addPet(Pet pet) async {
    try {
      await _firestore.collection('pets').add(pet.toMap());
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
