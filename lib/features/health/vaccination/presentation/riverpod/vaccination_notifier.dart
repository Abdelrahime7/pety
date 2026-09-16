import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/core/dependencies%20inection/di.dart';
import 'package:pet_care/core/services/vaccination_service.dart';
import 'package:pet_care/features/health/vaccination/data/vaccination_item_info.dart';
import 'package:pet_care/features/health/vaccination/domain/entity/vaccination1.dart';
import 'package:pet_care/features/health/vaccination/presentation/riverpod/vaccination_providers.dart';

class VaccinationNotifier
    extends FamilyAsyncNotifier<List<Vaccination>, String> {


  VaccinationService get _service =>
      ref.read(vaccinationServiceProvider);


  @override
  FutureOr<List<Vaccination>> build(String petId) async {
   

    final result = await _service.getVaccinations(petId);

    if (result is Success<List<Vaccination>>) {
      return result.data;
    }

    return [];
  }
 

 
 
  // ---------------------------------------------------------------------------
  // CREATE
  // ---------------------------------------------------------------------------

  Future<Result<void>> addVaccination(
    Vaccination vaccination,
  ) async {
    state = const AsyncLoading();

    try {
      final result = await _service.addVaccination(vaccination);

      if (result is Success<void>) {
        final vaccinationsResult =
            await _service.getVaccinations(vaccination.petId);

        if (vaccinationsResult is Success<List<Vaccination>>) {
          state = AsyncData(vaccinationsResult.data);


        } else {
          state = const AsyncData([]);
        }
        ref.invalidate( vaccinationInfoProvider(vaccination.petId));
        return result;
      }

      if (result is Failure<void>) {
        state = AsyncError(
          result.message,
          StackTrace.current,
        );

        return result;
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

  Future<Result<Vaccination>> getVaccination(
    String vaccinationId,
  ) async {
    try {
      return await _service.getVaccination(vaccinationId);
    } catch (e) {
      return Failure(e.toString());
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
      final result = await _service.updateVaccination(
        vaccinationId,
        data,
      );

      if (result is Success<void>) {
        final vaccinationsResult =
            await _service.getVaccinations(arg);

        if (vaccinationsResult is Success<List<Vaccination>>) {
          state = AsyncData(vaccinationsResult.data);
        } else if (vaccinationsResult is Failure<List<Vaccination>>) {
          state = AsyncError(
            vaccinationsResult.message,
            StackTrace.current,
          );
        }
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
      final result = await _service.deleteVaccination(
        vaccinationId,
      );

      if (result is Success<void>) {
        final vaccinationsResult =
            await _service.getVaccinations(arg);

        if (vaccinationsResult is Success<List<Vaccination>>) {
          state = AsyncData(vaccinationsResult.data);
        } else {
          state = const AsyncData([]);
        }

        return result;
      }

      if (result is Failure<void>) {
        state = AsyncError(
          result.message,
          StackTrace.current,
        );

        return result;
      }

      return result;
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);

      return Failure(e.toString());
    }
  }

  Future<Result<VaccItemInfo>> getVaccinationInfo() async {
    try {
      return await _service.getVaccinationInfo(arg);
    } catch (e) {
      return Failure(e.toString());
    }
  }
}