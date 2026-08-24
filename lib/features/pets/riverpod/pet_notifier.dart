import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/core/dependencies%20inection/di.dart';
import 'package:pet_care/core/services/pet_service.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet_care/features/pets/domain/entity/pet.dart';

class PetNotifier extends AsyncNotifier<List<Pet>> {
  
  late final PetService _service;
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

  Future<Result<void>> addPet(Pet pet) async {
    state = const AsyncLoading(); 

    // Safety check - make sure we assign the current logged in user
    final petWithOwner = Pet(
      id: pet.id,
      ownerId: _ownerId ?? '',
      name: pet.name,
      species: pet.species,
      breed: pet.breed,
      gender: pet.gender,
      birthDate: pet.birthDate,
      weight: pet.weight,
      medicalNotes: pet.medicalNotes,
    );

    final result = await _service.addPet(petWithOwner);

    switch (result) {
      case Success():
        if (_ownerId != null) {
          final updatedPets = await _service.getPets(_ownerId!);
          state = updatedPets is Success ? AsyncData((updatedPets as Success).data) : const AsyncData([]);
        }
        return result;

      case Failure(:final message):
        state = AsyncError(message, StackTrace.current);
        return result;

      case Cancelled():
        return result;
    }
  }
}

