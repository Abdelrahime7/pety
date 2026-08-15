

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/features/pets/riverpod/pet_notifier.dart';
import 'package:pet_care/features/pets/riverpod/pet_state.dart';

final petProvider = NotifierProvider<PetNotifier,PetState>(
   PetNotifier.new
);