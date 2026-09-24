import 'package:pet_care/features/health/domain/entity/health_record.dart';
import 'package:pet_care/features/pets/domain/entity/pet.dart';

class HealthState {
  final List<Pet> pets;
  final Pet? selectedPet;
  final List<HealthRecord> records;
  final Map<String, List<HealthRecord>> recordsByPet;
  final String selectedFilter;
  final bool isLoading;
  final String? error;

  const HealthState({
    this.pets = const [],
    this.selectedPet,
    this.records = const [],
    this.recordsByPet = const {},
    this.selectedFilter = 'All',
    this.isLoading = false,
    this.error,
  });

  HealthState copyWith({
    List<Pet>? pets,
    Pet? selectedPet,
    List<HealthRecord>? records,
    Map<String, List<HealthRecord>>? recordsByPet,
    String? selectedFilter,
    bool? isLoading,
    String? error,
  }) {
    return HealthState(
      pets: pets ?? this.pets,
      selectedPet: selectedPet ?? this.selectedPet,
      records: records ?? this.records,
      recordsByPet: recordsByPet ?? this.recordsByPet,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
