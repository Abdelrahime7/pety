 import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/features/health/vaccination/domain/entities/vaccination_record.dart';
import 'package:pet_care/features/health/vaccination/domain/entities/vaccination_serie.dart';
import 'package:pet_care/features/health/vaccination/presentation/riverpod/vaccination_notifier.dart';
import 'package:pet_care/features/health/vaccination/presentation/riverpod/vaccination_record_notifier.dart';
import 'package:pet_care/features/health/vaccination/presentation/riverpod/vaccination_serie_notifier%20.dart';

final vaccinationRecordProvider = AsyncNotifierProvider.family<
VaccinationRecordNotifier,
List<VaccinationRecord>,
 String >(
  VaccinationRecordNotifier.new
 );
  


final vaccinationSerieProvider = AsyncNotifierProvider.family<
VaccinationSerieNotifier,
List<VaccinationSerie>,
 String >(
  VaccinationSerieNotifier.new
 );
  
final vaccinationNotifierProvider =
    AsyncNotifierProviderFamily<
      VaccinationNotifier,
      void,
      String
    >(VaccinationNotifier.new);