

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/features/health/vaccination/data/vaccination_item_info.dart';
import 'package:pet_care/features/health/vaccination/domain/entity/vaccination1.dart';
import 'package:pet_care/infrastructure/firebase/firebase_store/firestore_mapprt.dart';
import 'package:pet_care/infrastructure/firebase/firebase_store/vaccination_data_source.dart';

class VaccinationService {
  final VaccinationDataSource dataSource;

  VaccinationService({
    required this.dataSource,
  });

  // ---------------------------------------------------------------------------
  // CREATE
  // ---------------------------------------------------------------------------

  Future<Result<void>> addVaccination(
    Vaccination vaccination,
  ) async {
    try {
      final vaccinationId = vaccination.id;

      if (vaccinationId == null || vaccinationId.isEmpty) {
        return const Failure(
          'Vaccination ID is required.',
        );
      }

      await dataSource.createVaccination(
        vaccinationId,
        vaccination.toMap(),
      );

      return const Success(null);
    } on FirebaseException catch (e) {
      return Failure(
        mapFirestoreExceptionToFailure(e).message,
      );
    } catch (e) {
      return Failure(
        e.toString(),
      );
    }
  }

  // ---------------------------------------------------------------------------
  // READ ALL FOR PET
  // ---------------------------------------------------------------------------

  Future<Result<List<Vaccination>>> getVaccinations(
    String petId,
  ) async {
    try {
      if (petId.isEmpty) {
        return const Failure(
          'Pet ID is required.',
        );
      }

      final data = await dataSource.getVaccinations(
        petId,
      );

      final vaccinations = data
          .map(
            (map) => Vaccination.fromMap(map),
          )
          .toList();

      return Success(vaccinations);
    } on FirebaseException catch (e) {
      return Failure(
        mapFirestoreExceptionToFailure(e).message,
      );
    } catch (e) {
      return Failure(
        e.toString(),
      );
    }
  }

  // ---------------------------------------------------------------------------
  // READ ONE
  // ---------------------------------------------------------------------------

  Future<Result<Vaccination>> getVaccination(
    String vaccinationId,
  ) async {
    try {
      if (vaccinationId.isEmpty) {
        return const Failure(
          'Vaccination ID is required.',
        );
      }

      final data = await dataSource.getVaccination(
        vaccinationId,
      );

      if (data == null) {
        return const Failure(
          'Vaccination not found.',
        );
      }

      final vaccination = Vaccination.fromMap(
        data,
      );

      return Success(vaccination);
    } on FirebaseException catch (e) {
      return Failure(
        mapFirestoreExceptionToFailure(e).message,
      );
    } catch (e) {
      return Failure(
        e.toString(),
      );
    }
  }

  // ---------------------------------------------------------------------------
  // UPDATE
  // ---------------------------------------------------------------------------

  Future<Result<void>> updateVaccination(
    String vaccinationId,
    Map<String, dynamic> data,
  ) async {
    try {
      if (vaccinationId.isEmpty) {
        return const Failure(
          'Vaccination ID is required.',
        );
      }

      await dataSource.updateVaccination(
        vaccinationId,
        data,
      );

      return const Success(null);
    } on FirebaseException catch (e) {
      return Failure(
        mapFirestoreExceptionToFailure(e).message,
      );
    } catch (e) {
      return Failure(
        e.toString(),
      );
    }
  }

  // ---------------------------------------------------------------------------
  // DELETE
  // ---------------------------------------------------------------------------

  Future<Result<void>> deleteVaccination(
    String vaccinationId,
  ) async {
    try {
      if (vaccinationId.isEmpty) {
        return const Failure(
          'Vaccination ID is required.',
        );
      }

      await dataSource.deleteVaccination(
        vaccinationId,
      );

      return const Success(null);
    } on FirebaseException catch (e) {
      return Failure(
        mapFirestoreExceptionToFailure(e).message,
      );
    } catch (e) {
      return Failure(
        e.toString(),
      );
    }
  }

  // ---------------------------------------------------------------------------
  // VACCINATION SUMMARY
  // ---------------------------------------------------------------------------

  Future<Result<VaccItemInfo>> getVaccinationInfo(
    String petId,
  ) async {
    try {
      if (petId.isEmpty) {
        return const Failure(
          'Pet ID is required.',
        );
      }

      final count = await dataSource.getVaccinationCount(
        petId,
      );

      final nextVaccination =
          await dataSource.getNextVaccination(
        petId,
      );

      if (nextVaccination == null) {
        return Success(
          (
            vaccinationsCount: count.toString(),
            nextVaccineName: 'None',
            nextDueDate: null,
          ),
        );
      }

      final vaccination = Vaccination.fromMap(
        nextVaccination,
      );

      return Success(
        (
          vaccinationsCount: count.toString(),
          nextVaccineName:
              vaccination.nextVaccineName ??
              vaccination.vaccineName,
          nextDueDate:
              vaccination.nextDueDate?.toString(),
        ),
      );
    } on FirebaseException catch (e) {
      return Failure(
        mapFirestoreExceptionToFailure(e).message,
      );
    } catch (e) {

      return Failure(
        e.toString(),
      );
    }
  }
}
