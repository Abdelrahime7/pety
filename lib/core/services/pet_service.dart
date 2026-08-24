import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/infrastructure/firebase/pets/firebase_pet_data_source.dart'; // From your friend's core/constant

class PetService {
  final PetFirestoreDataSource dataSource;

  PetService({required this.dataSource});

  Future<Result<void>> addPet(Map<String, dynamic> petData) async {
    try {
      await dataSource.addPet(petData);
      return const Success(null);
    } catch (e) {
      return Failure(e.toString());
    }
  }

  Future<Result<List<Map<String, dynamic>>>> getPets() async {
    try {
      final pets = await dataSource.getPets();
      return Success(pets);
    } catch (e) {
      return Failure(e.toString());
    }
  }
}
