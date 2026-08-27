import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/core/dependencies%20inection/di.dart';
import 'package:pet_care/core/services/image_storage_service.dart';
import 'package:pet_care/core/services/pet_service.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import 'package:pet_care/features/pets/domain/entity/pet.dart';

class PetNotifier extends AsyncNotifier<List<Pet>> {
  late final PetService _service;
  late final ImageService _imageService;

  String? get _ownerId => FirebaseAuth.instance.currentUser?.uid;

  @override
  FutureOr<List<Pet>> build() async {
    _service = ref.read(petServiceProvider);

    if (_ownerId == null) return [];

    final result = await _service.getPets(_ownerId!);
    if (result is Success) {
      return (result as Success).data;
    }
    return [];
  }

  //  FIX: Copy file to app sandbox before uploading
  Future<File> _copyToAppDirectory(File original) async {
    final dir = await getTemporaryDirectory();
    final newPath = path.join(dir.path, path.basename(original.path));
    return await original.copy(newPath);
  }

  //  Upload image to Cloudinary securely via REST
  Future<Result<String>> _uploadPetImage(File? image, String petId) async {      

  if (image == null) {
    return Failure("image is null");
  }

  return _imageService.uploadImage(
    image: image,
    folder: 'users',
    publicId: petId,
  );
}


  

  // addPet with image upload
  Future<Result<void>> addPet(Pet pet, {File? image}) async {
    state = const AsyncLoading();

    try {
      // 1️ Generate ID before upload
      final petId = DateTime.now().millisecondsSinceEpoch.toString();

      // 2️ Upload image
      final photoUrl = await _uploadPetImage(image, petId);

      // 3️ Build final Pet object
      final petWithOwner = Pet(
        id: petId,
        ownerId: _ownerId ?? '',
        name: pet.name,
        species: pet.species,
        breed: pet.breed,
        gender: pet.gender,
        birthDate: pet.birthDate,
        weight: pet.weight,
        medicalNotes: pet.medicalNotes,
        photoUrl: photoUrl.toString(),
      );

      // 4 Save to Firestore
      final result = await _service.addPet(petWithOwner);

      // 5️ Update state
      if (result is Success) {
        if (_ownerId != null) {
          final updatedPets = await _service.getPets(_ownerId!);
          state = updatedPets is Success
              ? AsyncData((updatedPets as Success).data)
              : const AsyncData([]);
        }
        return result;
      }

      if (result is Failure) {
        state = AsyncError(result.message, StackTrace.current);
        return result;
      }

      return result;
    } catch (e) {
      state = AsyncError(e.toString(), StackTrace.current);
      return Failure(e.toString());
    }
  }
}
