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
    state = state.copyWith(isLoading: true, error: null);
    final ownerId = FirebaseAuth.instance.currentUser?.uid;
    if (ownerId == null) {
      state = const HealthState(isLoading: false);
      return;
    }

    final result = await _petService.getPets(ownerId);
    if (result is Success<List<Pet>>) {
      final pets = result.data;
      if (pets.isEmpty) {
        state = const HealthState(isLoading: false, pets: []);
        return;
      }

      final recordsByPet = <String, List<HealthRecord>>{};
      for (final pet in pets) {
        final recordsResult = await _healthService.getRecords(pet.id);
        if (recordsResult is Success<List<HealthRecord>>) {
          recordsByPet[pet.id] = recordsResult.data;
        } else {
          recordsByPet[pet.id] = [];
        }
      }

      final selected = state.selectedPet != null &&
              pets.any((p) => p.id == state.selectedPet!.id)
          ? state.selectedPet!
          : pets.first;

      state = HealthState(
        pets: pets,
        selectedPet: selected,
        records: recordsByPet[selected.id] ?? [],
        recordsByPet: recordsByPet,
        isLoading: false,
      );
    } else if (result is Failure<List<Pet>>) {
      state = HealthState(isLoading: false, error: result.message);
    }
  }

  Future<void> selectPet(Pet pet) async {
    state = state.copyWith(
      selectedPet: pet,
      records: state.recordsByPet[pet.id] ?? [],
      selectedFilter: 'All',
    );

    final result = await _healthService.getRecords(pet.id);
    if (result is Success<List<HealthRecord>>) {
      final recordsByPet = Map<String, List<HealthRecord>>.from(state.recordsByPet)
        ..[pet.id] = result.data;
      state = state.copyWith(
        records: result.data,
        recordsByPet: recordsByPet,
      );
    }
  }

  void setSelectedFilter(String filter) {
    state = state.copyWith(selectedFilter: filter);
  }
}
