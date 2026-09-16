import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/features/pets/riverpod/pet_notifier.dart';
import 'package:pet_care/features/pets/domain/entity/pet.dart';

final petProvider = AsyncNotifierProvider<PetNotifier, List<Pet>>(
  PetNotifier.new,
);

// Keep one shared notifier instance for every pet screen.
final petNotifierProvider = petProvider;

/// Dynamically retrieves a pet by its ID from the cached pet list.
final petByIdProvider = Provider.family<Pet?, String>((ref, petId) {
  final pets = ref.watch(petProvider).valueOrNull ?? [];
  try {
    return pets.firstWhere((p) => p.id == petId);
  } catch (_) {
    return null;
  }
});