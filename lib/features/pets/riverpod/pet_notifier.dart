import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/core/dependencies%20inection/di.dart';
import 'package:pet_care/core/services/image_storage_service.dart';
import 'package:pet_care/core/services/pet_service.dart';
import 'package:pet_care/features/pets/data/pet_data.dart';
import 'package:pet_care/features/pets/domain/entity/pet.dart';
import 'package:uuid/uuid.dart';

class PetNotifier extends AsyncNotifier<List<Pet>> {
  late final PetService _service;
  late final ImageService _imageService;

  String? get _ownerId => FirebaseAuth.instance.currentUser?.uid;

  @override
  FutureOr<List<Pet>> build() async {
    _service = ref.read(petServiceProvider);
    _imageService = ref.read(imageServiceProvider);

    if (_ownerId == null) {
      return [];
    }

    final result = await _service.getPets(_ownerId!);

    if (result is Success<List<Pet>>) {
      return result.data;
    }

    return [];
  }

  // ---------------------------------------------------------------------------
  // IMAGE
  // ---------------------------------------------------------------------------

  Future<Result<String>> _uploadPetImage(
    File? image,
    final String publicId
  ) async {
    if (image == null) {
      return const Failure('Image is null');
    }

    return _imageService.uploadImage(
      image: image,
      folder: 'pets',
      publicId: publicId,
    );
  }

  // ---------------------------------------------------------------------------
  // CREATE
  // ---------------------------------------------------------------------------

  Future<Result<void>> addPet(
    Pet pet, {
    File? image,
  }) async {
    state = const AsyncLoading();

    try {
      if (_ownerId == null) {
        return const Failure('User is not logged in');
      }

      // Generate ID before saving to Firestore.
      final petId = const Uuid().v4();

      String? photoUrl;

      // Upload image only if provided.
      if (image != null) {
           final publicId= '${petId}_${DateTime.now().millisecondsSinceEpoch}';

        final imageResult = await _uploadPetImage(
          image,
          publicId,
        );

        if (imageResult is Success<String>) {
          photoUrl = imageResult.data;
        }
      }

      // Create final Pet object.
      final petWithId = Pet(
        id: petId,
        ownerId: _ownerId!,
        name: pet.name,
        species: pet.species,
        breed: pet.breed,
        gender: pet.gender,
        birthDate: pet.birthDate,
        weight: pet.weight,
        medicalNotes: pet.medicalNotes,
        photoUrl: photoUrl??"",
      );

      // Save to Firestore.
      final result = await _service.addPet(petWithId);

      if (result is Success<void>) {
        // Refresh state.
        final petsResult = await _service.getPets(_ownerId!);

        if (petsResult is Success<List<Pet>>) {
          state = AsyncData(petsResult.data);
        } else {
          state = const AsyncData([]);
        }

        return result;
      }

      if (result is Failure<void>) {
        state = AsyncError(
          result.message,
          StackTrace.current,
        );

        return result;
      }

      return result;
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);

      return Failure(e.toString());
    }
  }

  // ---------------------------------------------------------------------------
  // READ ONE
  // ---------------------------------------------------------------------------

  Future<Result<Pet>> getPet(String petId) async {
    try {
      return await _service.getPet(petId);
    } catch (e) {
      return Failure(e.toString());
    }
  }

  // ---------------------------------------------------------------------------
  // UPDATE
  // ---------------------------------------------------------------------------

Future<Result<void>> updatePet(
  PetRequest request, {
  File? image,
}) async {
  try {
    if (_ownerId == null) {
      return const Failure('User is not logged in');
    }

    final data = toPatchMap(request);

    if (image != null) {
      final publicId =
          '${request.id}_${DateTime.now().millisecondsSinceEpoch}';

      final imageResult = await _uploadPetImage(
        image,
        publicId,
      );

      if (imageResult is Success<String>) {
        data['photoUrl'] = imageResult.data;
      }
    }

    final result = await _service.updatePet(
      request.id,
      data,
    );

    if (result is Success<void>) {
      final petsResult = await _service.getPets(_ownerId!);

      if (petsResult is Success<List<Pet>>) {
        state = AsyncData(petsResult.data);
      } else if (petsResult is Failure<List<Pet>>) {
        state = AsyncError(
          petsResult.message,
          StackTrace.current,
        );
      }
    }

    return result;
  } catch (e, stackTrace) {
    state = AsyncError(e, stackTrace);
    return Failure(e.toString());
  }
}

  // ---------------------------------------------------------------------------
  // DELETE
  // ---------------------------------------------------------------------------

  Future<Result<void>> deletePet(String petId) async {
    state = const AsyncLoading();

    try {
      if (_ownerId == null) {
        return const Failure('User is not logged in');
      }

      final result = await _service.deletePet(petId);

      if (result is Success<void>) {
        final petsResult = await _service.getPets(_ownerId!);

        if (petsResult is Success<List<Pet>>) {
          state = AsyncData(petsResult.data);
        } else {
          state = const AsyncData([]);
        }

        return result;
      }

      if (result is Failure<void>) {
        state = AsyncError(
          result.message,
          StackTrace.current,
        );

        return result;
      }

      return result;
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);

      return Failure(e.toString());
    }
  }
}