 import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/features/health/vaccination/domain/entity/vaccination1.dart';
import 'package:pet_care/features/health/vaccination/presentation/riverpod/vaccination_provider.dart';

final vaccinationProvider = AsyncNotifierProvider.family<
VaccinationNotifier,
List<Vaccination>,
 String >(
  VaccinationNotifier.new
 );
  
