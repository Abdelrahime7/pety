import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/core/dependencies%20inection/di.dart';
import 'package:pet_care/core/services/appointment_service.dart';
import 'package:pet_care/core/services/pet_service.dart';
import 'package:pet_care/features/appointments/domain/entity/appointment.dart';
import 'package:pet_care/features/appointments/presentation/riverpod/appointment_state.dart';
import 'package:pet_care/features/pets/domain/entity/pet.dart';
import 'package:uuid/uuid.dart';

class AppointmentNotifier extends Notifier<AppointmentState> {
  late final AppointmentService _service;
  late final PetService _petService;

  String? get _ownerId => FirebaseAuth.instance.currentUser?.uid;

  @override
  AppointmentState build() {
    _service = ref.read(appointmentServiceProvider);
    _petService = ref.read(petServiceProvider);

    Future.microtask(fetchAppointments);

    return const AppointmentState(isLoading: true);
  }

  // READ ALL
  Future<void> fetchAppointments() async {
    if (_ownerId == null) {
      state = state.copyWith(appointments: [], isLoading: false);
      return;
    }

    state = state.copyWith(isLoading: true, error: () => null);

    try {
      // 1. Get all pets belonging to the owner
      final petsResult = await _petService.getPets(_ownerId!);

      if (petsResult is Failure<List<Pet>>) {
        state = state.copyWith(isLoading: false, error: () => petsResult.message);
        return;
      }

      final pets = (petsResult as Success<List<Pet>>).data;
      if (pets.isEmpty) {
        state = state.copyWith(appointments: [], isLoading: false);
        return;
      }

      final petIds = pets.map((p) => p.id).toList();

      // 2. Fetch appointments for these pets
      final result = await _service.getAppointmentsForPets(petIds);

      if (result is Success<List<Appointment>>) {
        state = state.copyWith(appointments: result.data, isLoading: false);
      } else if (result is Failure<List<Appointment>>) {
        state = state.copyWith(isLoading: false, error: () => result.message);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: () => e.toString());
    }
  }

  // CREATE
  Future<Result<void>> addAppointment({
    required String petId,
    required DateTime date,
    required String veterinarian,
    String notes = '',
  }) async {
    state = state.copyWith(isLoading: true, error: () => null);

    try {
      if (_ownerId == null) {
        state = state.copyWith(isLoading: false);
        return const Failure('User is not logged in');
      }

      final appointment = Appointment(
        appointmentId: const Uuid().v4(),
        petId: petId,
        date: date,
        veterinarian: veterinarian,
        notes: notes,
      );

      final result = await _service.addAppointment(appointment);

      if (result is Success<void>) {
        await fetchAppointments();
        return result;
      }

      if (result is Failure<void>) {
        state = state.copyWith(isLoading: false, error: () => result.message);
        return result;
      }

      return result;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: () => e.toString());
      return Failure(e.toString());
    }
  }

  Future<Result<void>> updateAppointment(Appointment appointment) async {
    state = state.copyWith(isLoading: true, error: () => null);

    final result = await _service.updateAppointment(
      appointment.appointmentId,
      appointment.toMap(),
    );

    if (result is Success<void>) {
      await fetchAppointments();
    } else if (result is Failure<void>) {
      state = state.copyWith(isLoading: false, error: () => result.message);
    }

    return result;
  }

  // DELETE
  Future<Result<void>> deleteAppointment(String appointmentId) async {
    state = state.copyWith(isLoading: true, error: () => null);

    try {
      if (_ownerId == null) {
        state = state.copyWith(isLoading: false);
        return const Failure('User is not logged in');
      }

      final result = await _service.deleteAppointment(appointmentId);

      if (result is Success<void>) {
        await fetchAppointments();
        return result;
      }

      if (result is Failure<void>) {
        state = state.copyWith(isLoading: false, error: () => result.message);
        return result;
      }

      return result;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: () => e.toString());
      return Failure(e.toString());
    }
  }
}