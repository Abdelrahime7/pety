import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/infrastructure/firebase/firebase_store/firestore_mapprt.dart';
import 'package:pet_care/infrastructure/firebase/pets/firebase_pet_data_source.dart';
import 'package:pet_care/features/pets/domain/entity/pet.dart';

class PetService {
  final PetFirestoreDataSource dataSource;

  PetService({required this.dataSource});

  

  Future<Result<void>> addPet(Pet pet) async {
    try {
      await dataSource.addPet(pet);
      return const Success(null);
    } on FirebaseException catch (e) {
      return Failure(mapFirestoreExceptionToFailure(e).message);
    } catch (_) {
      return const Failure("Something went wrong");
    }
  }

  Future<Result<List<Pet>>> getPets(String ownerId) async {
    try {
      final docs = await dataSource.getPets(ownerId);
      final pets = docs.map((doc) => Pet.fromFirestore(doc)).toList();
      
      return Success(pets);
    } on FirebaseException catch (e) {
      return Failure(mapFirestoreExceptionToFailure(e).message);
    } catch (_) {
      return const Failure("Something went wrong");
    }
  }
}

