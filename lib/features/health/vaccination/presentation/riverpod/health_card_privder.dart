

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/features/health/vaccination/domain/entities/helath_card_info.dart';
import 'package:pet_care/features/health/vaccination/presentation/riverpod/health_card_notifier.dart';


final  healthCardProvider=  AsyncNotifierProvider.family<
HealthCardInfoNotifier,
HealthCardInfo,
String
>(
  HealthCardInfoNotifier.new
);