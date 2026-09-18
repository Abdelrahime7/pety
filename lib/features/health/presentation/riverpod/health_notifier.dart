import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/core/dependencies%20inection/di.dart';
import 'package:pet_care/core/services/health_service.dart';
import 'package:pet_care/core/services/pet_service.dart';
import 'package:pet_care/features/health/domain/entity/health_record.dart';
import 'package:pet_care/features/pets/domain/entity/pet.dart';
import 'package:pet_care/features/health/presentation/riverpod/health_state.dart';

class HealthNotifier extends Notifier<HealthState> {
  late final HealthService _healthService;
  late final PetService _petService;

  @override
  HealthState build() {
    _healthService = ref.read(healthServiceProvider);
    _petService = ref.read(petServiceProvider);
    Future.microtask(loadPets);
    return const HealthState(isLoading: true);
  }

  Future<void> loadPets() async {
    final ownerId = FirebaseAuth.instance.currentUser?.uid;
    if (ownerId == null) {
      state = const HealthState();
      return;
    }

    final result = await _petService.getPets(ownerId);
    if (result is Success<List<Pet>>) {
      final pets = result.data;
      final recordsByPet = <String, List<HealthRecord>>{};
      for (final pet in pets) {
        final recordsResult = await _healthService.getRecords(pet.id);
        if (recordsResult is Success<List<HealthRecord>>) {
          recordsByPet[pet.id] = recordsResult.data;
        }
      }
      state = HealthState(
        pets: pets,
        selectedPet: pets.isEmpty ? null : pets.first,
        recordsByPet: recordsByPet,
        isLoading: false,
      );
      if (pets.isNotEmpty) {
        state = state.copyWith(records: recordsByPet[pets.first.id] ?? []);
      }
    } else if (result is Failure<List<Pet>>) {
      state = HealthState(isLoading: false, error: result.message);
    }
  }

  Future<void> selectPet(Pet pet) async {
    state = state.copyWith(selectedPet: pet, isLoading: true, error: null);
    final result = await _healthService.getRecords(pet.id);
    if (result is Success<List<HealthRecord>>) {
      final recordsByPet = Map<String, List<HealthRecord>>.from(state.recordsByPet)
        ..[pet.id] = result.data;
      state = state.copyWith(records: result.data, recordsByPet: recordsByPet, isLoading: false);
    } else if (result is Failure<List<HealthRecord>>) {
      state = state.copyWith(isLoading: false, error: result.message);
    }
  }
}
