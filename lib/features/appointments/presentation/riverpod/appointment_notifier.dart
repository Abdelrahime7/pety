

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/features/appointments/presentation/riverpod/appointment_state.dart';

class AppointmentNotifier extends Notifier<AppointmentState> {
  @override
  AppointmentState build() {
    return AppointmentState();
  }
}