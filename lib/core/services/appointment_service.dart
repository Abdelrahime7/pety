import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/infrastructure/firebase/appointment/firebase_appointment_data_source.dart';
import 'package:pet_care/infrastructure/firebase/firebase_store/firestore_mapprt.dart';
import 'package:pet_care/features/appointments/domain/entity/appointment.dart';

class AppointmentService {
  final AppointmentFirestoreDataSource dataSource;

  AppointmentService({required this.dataSource});

  // CREATE
  Future<Result<void>> addAppointment(Appointment appointment) async {
    try {
      await dataSource.addAppointment(appointment);
      return const Success(null);
    } on FirebaseException catch (e) {
      return Failure(mapFirestoreExceptionToFailure(e).message);
    } catch (_) {
      return const Failure('Something went wrong');
    }
  }

  // READ ALL FOR MULTIPLE PETS
  Future<Result<List<Appointment>>> getAppointmentsForPets(
    List<String> petIds,
  ) async {
    try {
      if (petIds.isEmpty) {
        return const Success([]);
      }

      final docs = await dataSource.getAppointmentsForPets(petIds);

      final appointments =
          docs.map((doc) => Appointment.fromFirestore(doc)).toList();

      // Sort by date ascending (earliest to latest) in-memory
      appointments.sort((a, b) => a.date.compareTo(b.date));

      return Success(appointments);
    } on FirebaseException catch (e) {
      return Failure(mapFirestoreExceptionToFailure(e).message);
    } catch (e, stack) {
      debugPrint('💥 getAppointmentsForPets error: $e\n$stack');
      return Failure(e.toString());
    }
  }

  // READ ALL (Legacy / fallback for an owner)
  Future<Result<List<Appointment>>> getAppointments(String ownerId) async {
    try {
      final docs = await dataSource.getAppointments(ownerId);

      final appointments =
          docs.map((doc) => Appointment.fromFirestore(doc)).toList();

      // Sort by date ascending (earliest to latest) in-memory
      appointments.sort((a, b) => a.date.compareTo(b.date));

      return Success(appointments);
    } on FirebaseException catch (e) {
      return Failure(mapFirestoreExceptionToFailure(e).message);
    } catch (e, stack) {
      debugPrint('💥 getAppointments error: $e\n$stack');
      return Failure(e.toString());
    }
  }

  // READ ALL (for a specific pet)
  Future<Result<List<Appointment>>> getAppointmentsForPet(String petId) async {
    try {
      final docs = await dataSource.getAppointmentsForPet(petId);

      final appointments =
          docs.map((doc) => Appointment.fromFirestore(doc)).toList();

      appointments.sort((a, b) => a.date.compareTo(b.date));

      return Success(appointments);
    } on FirebaseException catch (e) {
      return Failure(mapFirestoreExceptionToFailure(e).message);
    } catch (_) {
      return const Failure('Something went wrong');
    }
  }

  // READ ONE
  Future<Result<Appointment>> getAppointment(String appointmentId) async {
    try {
      final doc = await dataSource.getAppointment(appointmentId);

      if (!doc.exists) {
        return const Failure('Appointment not found');
      }

      return Success(Appointment.fromFirestore(doc));
    } on FirebaseException catch (e) {
      return Failure(mapFirestoreExceptionToFailure(e).message);
    } catch (_) {
      return const Failure('Something went wrong');
    }
  }

  // UPDATE
  Future<Result<void>> updateAppointment(
    String appointmentId,
    Map<String, dynamic> data,
  ) async {
    try {
      await dataSource.updateAppointment(appointmentId, data);

      return const Success(null);
    } on FirebaseException catch (e) {
      return Failure(mapFirestoreExceptionToFailure(e).message);
    } catch (_) {
      return const Failure('Something went wrong');
    }
  }

  // DELETE
  Future<Result<void>> deleteAppointment(String appointmentId) async {
    try {
      await dataSource.deleteAppointment(appointmentId);

      return const Success(null);
    } on FirebaseException catch (e) {
      return Failure(mapFirestoreExceptionToFailure(e).message);
    } catch (e) {
      return Failure(e.toString());
    }
  }
}