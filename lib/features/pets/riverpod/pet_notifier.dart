import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/core/dependencies%20inection/di.dart';
import 'package:pet_care/core/services/pet_service.dart';

class PetNotifier extends AsyncNotifier<List<Map<String, dynamic>>> {
  
  late final PetService _service;

  @override
  FutureOr<List<Map<String, dynamic>>> build() async {
    // Inject the service
    _service = ref.read(petServiceProvider);
    
    // Automatically fetch pets on load
    final result = await _service.getPets();
    if (result is Success) {
      return (result as Success).data;
    }
    return [];
  }

  Future<Result<void>> addPet(Map<String, dynamic> petData) async {
    state = const AsyncLoading(); // Sets UI to loading automatically

    final result = await _service.addPet(petData);

    switch (result) {
      case Success():
        // Refresh the list after adding
        final updatedPets = await _service.getPets();
        state = updatedPets is Success ? AsyncData((updatedPets as Success).data) : const AsyncData([]);
        return result;

      case Failure(:final message):
        state = AsyncError(message, StackTrace.current);
        return result;

      case Cancelled():
        return result;
    }
  }
}
