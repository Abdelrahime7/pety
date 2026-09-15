import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/features/pets/riverpod/pet_notifier.dart';
import 'package:pet_care/features/pets/domain/entity/pet.dart';

final petProvider = AsyncNotifierProvider<PetNotifier, List<Pet>>(
  PetNotifier.new,
);

final petNotifierProvider =
    AsyncNotifierProvider<PetNotifier, List<Pet>>(PetNotifier.new);

/// Dynamically retrieves a pet by its ID from the cached pet list.
final petByIdProvider = Provider.family<Pet?, String>((ref, petId) {
  final pets = ref.watch(petNotifierProvider).valueOrNull ?? [];
  try {
    return pets.firstWhere((p) => p.id == petId);
  } catch (_) {
    return null;
  }
});