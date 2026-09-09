import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/infrastructure/firebase/firebase_store/firestore_mapprt.dart';
import 'package:pet_care/infrastructure/firebase/pets/firebase_pet_data_source.dart';
import 'package:pet_care/features/pets/domain/entity/pet.dart';

class PetService {
  final PetFirestoreDataSource dataSource;

  PetService({required this.dataSource});

  // CREATE
  Future<Result<void>> addPet(Pet pet) async {
    try {
      await dataSource.addPet(pet);
      return const Success(null);
    } on FirebaseException catch (e) {
      return Failure(mapFirestoreExceptionToFailure(e).message);
    } catch (_) {
      return const Failure('Something went wrong');
    }
  }

  // READ ALL
  Future<Result<List<Pet>>> getPets(String ownerId) async {
    try {
      final docs = await dataSource.getPets(ownerId);

      final pets = docs.map((doc) => Pet.fromFirestore(doc)).toList();

      return Success(pets);
    } on FirebaseException catch (e) {
      return Failure(mapFirestoreExceptionToFailure(e).message);
    } catch (_) {
      return const Failure('Something went wrong');
    }
  }

  // READ ONE
  Future<Result<Pet>> getPet(String petId) async {
    try {
      final doc = await dataSource.getPet(petId);

      if (!doc.exists) {
        return const Failure('Pet not found');
      }

      return Success(Pet.fromFirestore(doc));
    } on FirebaseException catch (e) {
      return Failure(mapFirestoreExceptionToFailure(e).message);
    } catch (_) {
      return const Failure('Something went wrong');
    }
  }

  // UPDATE
  Future<Result<void>> updatePet(
    String petId,
    Map<String, dynamic> data,
  ) async {
    try {
      await dataSource.updatePet(petId, data);

      return const Success(null);
    } on FirebaseException catch (e) {
      return Failure(mapFirestoreExceptionToFailure(e).message);
    } catch (_) {
      return const Failure('Something went wrong');
    }
  }

  // DELETE
 Future<Result<void>> deletePet(String petId) async {
  try {
    await dataSource.deletePet(petId);


    return const Success(null);
  } on FirebaseException catch (e) {

    return Failure(mapFirestoreExceptionToFailure(e).message);
  } catch (e) {

    return Failure(e.toString());
  }
 }
}