import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_care/features/pets/domain/entity/pet.dart';

class PetFirestoreDataSource {
  final FirebaseFirestore _firestore;

  PetFirestoreDataSource(this._firestore);

  Future<void> addPet(Pet pet) async {
    await _firestore
        .collection('pets')
        .doc(pet.id)
        .set(pet.toMap());
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getPets(
    String ownerId,
  ) async {
    final snapshot = await _firestore
        .collection('pets')
        .where('ownerId', isEqualTo: ownerId)
        .get();

    return snapshot.docs;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getPet(
    String petId,
  ) async {
    return await _firestore
        .collection('pets')
        .doc(petId)
        .get();
  }

  Future<void> updatePet(
    String petId,
    Map<String, dynamic> data,
  ) async {
    await _firestore
        .collection('pets')
        .doc(petId)
        .update(data);
  }

  Future<void> deletePet(String petId) async {
    await _firestore
        .collection('pets')
        .doc(petId)
        .delete();
  }
}