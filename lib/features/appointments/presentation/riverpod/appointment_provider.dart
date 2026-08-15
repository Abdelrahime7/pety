
 import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/features/appointments/presentation/riverpod/appointment_notifier.dart';
import 'package:pet_care/features/appointments/presentation/riverpod/appointment_state.dart';

final  appointentProvider =NotifierProvider<AppointmentNotifier,AppointmentState>(
AppointmentNotifier.new
);