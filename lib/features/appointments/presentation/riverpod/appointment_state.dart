import 'package:pet_care/features/appointments/domain/entity/appointment.dart';

class AppointmentState {
  final bool isLoading;
  final String? error;
  final List<Appointment> appointments;

  const AppointmentState({
    this.isLoading = false,
    this.error,
    this.appointments = const [],
  });

  AppointmentState copyWith({
    bool? isLoading,
    String? Function()? error,
    List<Appointment>? appointments,
  }) {
    return AppointmentState(
      isLoading: isLoading ?? this.isLoading,
      error: error != null ? error() : this.error,
      appointments: appointments ?? this.appointments,
    );
  }
}