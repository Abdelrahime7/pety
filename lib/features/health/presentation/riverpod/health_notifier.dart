import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/core/dependencies%20inection/di.dart';
import 'package:pet_care/core/services/health_service.dart';
import 'package:pet_care/core/services/vaccination_service.dart';
import 'package:pet_care/features/health/domain/entity/health_item_entity.dart';
import 'package:pet_care/features/health/domain/entity/health_record.dart';
import 'package:pet_care/features/health/vaccination/domain/entities/vaccination_record.dart';

class HealthRecordsNotifier
    extends FamilyAsyncNotifier<List<HealthItem>, String> {
  late final HealthService _healthService;
  late final VaccinationService _vaccinationService;

  @override
  FutureOr<List<HealthItem>> build(String petId) async {
    _healthService = ref.read(healthServiceProvider);
    _vaccinationService = ref.read(vaccinationRecordServiceProvider);

    final healthResult = await _healthService.getRecords(petId);

    if (healthResult is Failure<List<HealthRecord>>) {
      state = AsyncError(
        healthResult.message,
        StackTrace.current,
      );

      return [];
    }

    final vaccinationResult =
        await _vaccinationService.getAll(petId);

    if (vaccinationResult is Failure<List<VaccinationRecord>>) {
      state = AsyncError(
        vaccinationResult.message,
        StackTrace.current,
      );

      return [];
    }

    final healthRecords =
        healthResult is Success<List<HealthRecord>>
            ? healthResult.data
            : <HealthRecord>[];

    final vaccinationRecords =
        vaccinationResult is Success<List<VaccinationRecord>>
            ? vaccinationResult.data
            : <VaccinationRecord>[];

    final items = <HealthItem>[
      ...healthRecords,
      ...vaccinationRecords,
    ];

    items.sort(
      (a, b) => b.date.compareTo(a.date),
    );

    return items;
  }

  // ---------------------------------------------------------------------------
  // REFRESH
  // ---------------------------------------------------------------------------

  Future<void> refreshRecords() async {
    state = const AsyncLoading();

    try {
      final healthResult =
          await _healthService.getRecords(arg);

      if (healthResult is Failure<List<HealthRecord>>) {
        state = AsyncError(
          healthResult.message,
          StackTrace.current,
        );
        return;
      }

      final vaccinationResult =
          await _vaccinationService.getAll(arg);

      if (vaccinationResult is Failure<List<VaccinationRecord>>) {
        state = AsyncError(
          vaccinationResult.message,
          StackTrace.current,
        );
        return;
      }

      final healthRecords =
          healthResult is Success<List<HealthRecord>>
              ? healthResult.data
              : <HealthRecord>[];

      final vaccinationRecords =
          vaccinationResult is Success<List<VaccinationRecord>>
              ? vaccinationResult.data
              : <VaccinationRecord>[];

      final items = <HealthItem>[
        ...healthRecords,
        ...vaccinationRecords,
      ];

      items.sort(
        (a, b) => b.date.compareTo(a.date),
      );

      state = AsyncData(items);
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }

  // ---------------------------------------------------------------------------
  // CREATE HEALTH RECORD
  // ---------------------------------------------------------------------------

  Future<Result<void>> createRecord(
    HealthRecord record,
  ) async {
    state = const AsyncLoading();

    try {
      final result =
          await _healthService.createRecord(record);

      if (result is Success<void>) {
        await refreshRecords();
      }

      if (result is Failure<void>) {
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