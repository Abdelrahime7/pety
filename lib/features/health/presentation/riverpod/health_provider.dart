 

 import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/features/health/presentation/riverpod/health_notifier.dart';
import 'package:pet_care/features/health/presentation/riverpod/health_state.dart';


final healthProvider = NotifierProvider<HealthNotifier,HealthState>(
  HealthNotifier.new
);