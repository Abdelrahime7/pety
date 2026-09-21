import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/core/dependencies%20inection/di.dart';
import 'package:pet_care/core/services/vaccination_service.dart';
import 'package:pet_care/features/health/vaccination/domain/entities/vaccination_record.dart';

class VaccinationRecordNotifier
    extends FamilyAsyncNotifier<List<VaccinationRecord>, String> {

  VaccinationService<VaccinationRecord> get _service =>
      ref.read(vaccinationRecordServiceProvider);

  // ---------------------------------------------------------------------------
  // BUILD / READ ALL
  // ---------------------------------------------------------------------------

  @override
  FutureOr<List<VaccinationRecord>> build(String petId) async {
    final result = await _service.getAll(petId);

    if (result is Success<List<VaccinationRecord>>) {
      return result.data;
    }

    return [];
  }

  // ---------------------------------------------------------------------------
  // CREATE
  // ---------------------------------------------------------------------------

  Future<Result<void>> createVaccination(
    VaccinationRecord vaccination,
  ) async {
    state = const AsyncLoading();

    try {
      if (vaccination.id == null || vaccination.id!.isEmpty) {
        return const Failure('Vaccination ID is required.');
      }

      final result = await _service.create(
        vaccination.id!,
        vaccination.toMap(),
      );

      if (result is Success<void>) {
        final refreshedResult = await _service.getAll(arg);

        if (refreshedResult is Success<List<VaccinationRecord>>) {
          state = AsyncData(refreshedResult.data);
        } else if (refreshedResult is Failure<List<VaccinationRecord>>) {
          state = AsyncError(
            refreshedResult.message,
            StackTrace.current,
          );
        }
      } else if (result is Failure<void>) {
        state = AsyncError(
          result.message,
          StackTrace.current,
        );
      }

      return result;
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
      return Failure(e.toString());
    }
  }

  // ---------------------------------------------------------------------------
  // READ ONE
  // ---------------------------------------------------------------------------

  Future<Result<VaccinationRecord>> getVaccination(
    String vaccinationId,
  ) async {
    try {
      return await _service.getById(vaccinationId);
    } catch (e) {
      return Failure(e.toString());
    }
  }

  // ---------------------------------------------------------------------------
  // UPDATE
  // ---------------------------------------------------------------------------

  Future<Result<void>> updateVaccination(
    VaccinationRecord vaccination,
  ) async {
    try {
      if (vaccination.id == null || vaccination.id!.isEmpty) {
        return const Failure('Vaccination ID is required.');
      }

      final result = await _service.update(
        vaccination.id!,
        vaccination.toMap(),
      );

      if (result is Success<void>) {
        final refreshedResult = await _service.getAll(arg);

        if (refreshedResult is Success<List<VaccinationRecord>>) {
          state = AsyncData(refreshedResult.data);
        } else if (refreshedResult is Failure<List<VaccinationRecord>>) {
          state = AsyncError(
            refreshedResult.message,
            StackTrace.current,
          );
        }
      } else if (result is Failure<void>) {
        state = AsyncError(
          result.message,
          StackTrace.current,
        );
      }

      return result;
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
      return Failure(e.toString());
    }
  }

  // ---------------------------------------------------------------------------
  // DELETE
  // ---------------------------------------------------------------------------

  Future<Result<void>> deleteVaccination(
    String vaccinationId,
  ) async {
    state = const AsyncLoading();

    try {
      final result = await _service.delete(vaccinationId);

      if (result is Success<void>) {
        final refreshedResult = await _service.getAll(arg);

        if (refreshedResult is Success<List<VaccinationRecord>>) {
          state = AsyncData(refreshedResult.data);
        } else if (refreshedResult is Failure<List<VaccinationRecord>>) {
          state = AsyncError(
            refreshedResult.message,
            StackTrace.current,
          );
        }
      } else if (result is Failure<void>) {
        state = AsyncError(
          result.message,
          StackTrace.current,
        );
      }

      return result;
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
      return Failure(e.toString());
    }
  }
}