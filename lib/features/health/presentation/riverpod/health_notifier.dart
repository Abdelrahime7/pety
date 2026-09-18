import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/features/health/presentation/riverpod/health_state.dart';

class HealthNotifier extends Notifier<HealthState> {
  @override
  HealthState build() {
    return HealthState();
  }
}
