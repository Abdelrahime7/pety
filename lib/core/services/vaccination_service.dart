import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/features/health/vaccination/domain/entity/vaccination1.dart';
import 'package:pet_care/infrastructure/firebase/firebase_store/firestore_mapprt.dart';
import 'package:pet_care/infrastructure/firebase/firebase_store/vaccination_data_source.dart';

class VaccinationService {
  final VaccinationDataSource dataSource;

  VaccinationService({required this.dataSource});

  // CREATE
  Future<Result<void>> addVaccination(
    Vaccination vaccination,
  ) async {
    try {
      await dataSource.createVaccination(
        vaccination.petId,
        vaccination.id!,
        vaccination.toFirestore(),
      );

      return const Success(null);
    } on FirebaseException catch (e) {
      return Failure(
        mapFirestoreExceptionToFailure(e).message,
      );
    } catch (_) {
      return const Failure('Something went wrong');
    }
  }

  // READ ALL
  Future<Result<List<Vaccination>>> getVaccinations(
    String petId,
  ) async {
    try {
      final docs = await dataSource.getVaccinations(petId);

      final vaccinations = docs
          .map((doc) => Vaccination.fromFirestore(doc))
          .toList();

      return Success(vaccinations);
    } on FirebaseException catch (e) {
      return Failure(
        mapFirestoreExceptionToFailure(e).message,
      );
    } catch (_) {
      return const Failure('Something went wrong');
    }
  }

  // READ ONE
  Future<Result<Vaccination>> getVaccination(
    String petId,
    String vaccinationId,
  ) async {
    try {
      final doc = await dataSource.getVaccination(
        petId,
        vaccinationId,
      );

      if (!doc.exists) {
        return const Failure('Vaccination not found');
      }

      return Success(
        Vaccination.fromFirestore(doc),
      );
    } on FirebaseException catch (e) {
      return Failure(
        mapFirestoreExceptionToFailure(e).message,
      );
    } catch (_) {
      return const Failure('Something went wrong');
    }
  }

  // UPDATE
  Future<Result<void>> updateVaccination(
    String petId,
    String vaccinationId,
    Map<String, dynamic> data,
  ) async {
    try {
      await dataSource.updateVaccination(
        petId,
        vaccinationId,
        data,
      );

      return const Success(null);
    } on FirebaseException catch (e) {
      return Failure(
        mapFirestoreExceptionToFailure(e).message,
      );
    } catch (_) {
      return const Failure('Something went wrong');
    }
  }

  // DELETE
  Future<Result<void>> deleteVaccination(
    String petId,
    String vaccinationId,
  ) async {
    try {
      await dataSource.deleteVaccination(
        petId,
        vaccinationId,
      );

      return const Success(null);
    } on FirebaseException catch (e) {
      return Failure(
        mapFirestoreExceptionToFailure(e).message,
      );
    } catch (_) {
      return const Failure('Something went wrong');
    }
  }
}