

// ignore: camel_case_types, subtype_of_sealed_class
class AppointmentState {
  final bool isLoading;
  final String? error;

  AppointmentState({
    this.isLoading = false,
    this.error,
  });
}