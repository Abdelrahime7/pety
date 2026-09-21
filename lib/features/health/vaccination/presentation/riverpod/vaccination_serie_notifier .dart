import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/core/dependencies%20inection/di.dart';
import 'package:pet_care/core/services/vaccination_service.dart';
import 'package:pet_care/features/health/vaccination/domain/entities/vaccination_serie.dart';

class VaccinationSerieNotifier
    extends FamilyAsyncNotifier<List<VaccinationSerie>, String> {

  VaccinationService<VaccinationSerie> get _service =>
      ref.read(vaccinationSerieServiceProvider);

  // ---------------------------------------------------------------------------
  // BUILD / READ ALL
  // ---------------------------------------------------------------------------

 @override
Future<List<VaccinationSerie>> build(String petId) async {
  final result = await _service.getAll(petId);

  return switch (result) {
    Success<List<VaccinationSerie>>(:final data) => data,
    Failure<List<VaccinationSerie>>() => throw (result.message),
    Cancelled<List<VaccinationSerie>>() => [],
  };
}
  // ---------------------------------------------------------------------------
  // CREATE
  // ---------------------------------------------------------------------------

  Future<Result<void>> createSerie(
    VaccinationSerie serie,
  ) async {
    state = const AsyncLoading();

    try {
      if (serie.id == null || serie.id!.isEmpty) {
        return const Failure('Vaccination serie ID is required.');
      }

      final result = await _service.create(
        serie.id!,
        serie.toMap(),
      );

      if (result is Success<void>) {
        final refreshedResult = await _service.getAll(arg);

        if (refreshedResult is Success<List<VaccinationSerie>>) {
          state = AsyncData(refreshedResult.data);
        } else if (refreshedResult is Failure<List<VaccinationSerie>>) {
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

  Future<Result<VaccinationSerie>> getSerie(
    String serieId,
  ) async {
    try {
      return await _service.getById(serieId);
    } catch (e) {
      return Failure(e.toString());
    }
  }

  // ---------------------------------------------------------------------------
  // UPDATE
  // ---------------------------------------------------------------------------

  Future<Result<void>> updateSerie(
    VaccinationSerie serie,
  ) async {
    try {
      if (serie.id == null || serie.id!.isEmpty) {
        return const Failure('Vaccination serie ID is required.');
      }

      final result = await _service.update(
        serie.id!,
        serie.toMap(),
      );

      if (result is Success<void>) {
        final refreshedResult = await _service.getAll(arg);

        if (refreshedResult is Success<List<VaccinationSerie>>) {
          state = AsyncData(refreshedResult.data);
        } else if (refreshedResult is Failure<List<VaccinationSerie>>) {
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

  Future<Result<void>> deleteSerie(
    String serieId,
  ) async {
    state = const AsyncLoading();

    try {
      final result = await _service.delete(serieId);

      if (result is Success<void>) {
        final refreshedResult = await _service.getAll(arg);

        if (refreshedResult is Success<List<VaccinationSerie>>) {
          state = AsyncData(refreshedResult.data);
        } else if (refreshedResult is Failure<List<VaccinationSerie>>) {
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