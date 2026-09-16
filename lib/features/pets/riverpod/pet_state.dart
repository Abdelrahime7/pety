import 'package:pet_care/features/pets/domain/entity/pet.dart';

class PetState {
  final bool isLoading;
  final String? error;
  final List<Pet> pets;

  const PetState({
    this.isLoading = false,
    this.error,
    this.pets = const [],
  });

  PetState copyWith({
    bool? isLoading,
    String? Function()? error,
    List<Pet>? pets,
  }) {
    return PetState(
      isLoading: isLoading ?? this.isLoading,
      error: error != null ? error() : this.error,
      pets: pets ?? this.pets,
    );
  }
}