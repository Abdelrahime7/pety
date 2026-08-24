

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/features/pets/riverpod/pet_notifier.dart';
import 'package:pet_care/features/pets/riverpod/pet_state.dart';

import 'package:pet_care/features/pets/domain/entity/pet.dart';

final petProvider = AsyncNotifierProvider<PetNotifier, List<Pet>>(
   PetNotifier.new
);