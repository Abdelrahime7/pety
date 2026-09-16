 import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/features/health/vaccination/data/vaccination_item_info.dart';
import 'package:pet_care/features/health/vaccination/domain/entity/vaccination1.dart';
import 'package:pet_care/features/health/vaccination/presentation/riverpod/vaacination_info_notifier.dart';
import 'package:pet_care/features/health/vaccination/presentation/riverpod/vaccination_notifier.dart';

final vaccinationProvider = AsyncNotifierProvider.family<
VaccinationNotifier,
List<Vaccination>,
 String >(
  VaccinationNotifier.new
 );
  

final vaccinationInfoProvider =
    AsyncNotifierProviderFamily<
      VaccinationInfoNotifier,
      VaccItemInfo,
      String
    >(
      VaccinationInfoNotifier.new,
    );