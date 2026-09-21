import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/core/dependencies%20inection/di.dart';
import 'package:pet_care/core/services/vaccination_service.dart';
import 'package:pet_care/features/health/vaccination/domain/entities/add_vaccination_request.dart';
import 'package:pet_care/features/health/vaccination/domain/entities/vaccination_record.dart';
import 'package:pet_care/features/health/vaccination/domain/entities/vaccination_serie.dart';
import 'package:pet_care/features/health/vaccination/presentation/riverpod/health_card_privder.dart';
import 'package:pet_care/features/health/vaccination/presentation/riverpod/vaccination_providers.dart';
import 'package:uuid/uuid.dart';

class VaccinationNotifier
    extends FamilyAsyncNotifier<void, String> {

  VaccinationService<VaccinationRecord> get _recordService =>
      ref.read(vaccinationRecordServiceProvider);

  VaccinationService<VaccinationSerie> get _serieService =>
      ref.read(vaccinationSerieServiceProvider);

  @override
  FutureOr<void> build(String petId) {}

  Future<Result<void>> addVaccination(
    AddVaccinationRequest request,
  ) async {
    try {
      late VaccinationSerie serie;
      late int doseNumber;

      // ==========================================================
      // RESOLVE SERIES
      // ==========================================================

      if (request.isNewSeries) {
        // -----------------------------
        // Validate new series
        // -----------------------------

        if (request.vaccineName == null ||
            request.vaccineName!.trim().isEmpty) {
          return const Failure(
            'Vaccine name is required.',
          );
        }

        if (request.requiredDoses == null ||
            request.requiredDoses! <= 0) {
          return const Failure(
            'Number of doses must be greater than 0.',
          );
        }

        // -----------------------------
        // Create new series
        // -----------------------------

        serie = VaccinationSerie(
          id: const Uuid().v4(),
          petId: request.petId,
          vaccineName: request.vaccineName!.trim(),
          requiredDoses: request.requiredDoses!,
          completedDoses: 0,
          isCompleted: false,
          createdAt: DateTime.now(),
        );

        final seriesResult = await _serieService.create(
          serie.id!,
          serie.toMap(),
        );

        if (seriesResult is Failure<void>) {
          return Failure(seriesResult.message);
        }

        // New series always starts with dose 1.
        doseNumber = 1;
      }

      // ==========================================================
      // EXISTING SERIES
      // ==========================================================

      else {
        final seriesResult = await _serieService.getById(
          request.seriesId!,
        );

        if (seriesResult is Failure<VaccinationSerie>) {
          return Failure(seriesResult.message);
        }

        final success =
            seriesResult as Success<VaccinationSerie>;

        serie = success.data;

        // -----------------------------
        // Prevent completed series
        // -----------------------------

        if (serie.isCompleted ||
            serie.completedDoses >= serie.requiredDoses) {
          return const Failure(
            'This vaccination series is already complete.',
          );
        }

        // -----------------------------
        // Determine next dose
        // -----------------------------

        doseNumber = serie.completedDoses + 1;
      }

      // ==========================================================
      // CREATE VACCINATION RECORD
      // ==========================================================

      final vaccination = VaccinationRecord(
        id: const Uuid().v4(),
        petId: request.petId,
        seriesId: serie.id,
        vaccineName: serie.vaccineName,
        doseNumber: doseNumber,
        vaccinationDate: request.vaccinationDate,
        notes: request.notes,
      );

      final recordResult = await _recordService.create(
        vaccination.id!,
        vaccination.toMap(),
      );

      if (recordResult is Failure<void>) {
        return Failure(recordResult.message);
      }

      // ==========================================================
      // UPDATE SERIES PROGRESS
      // ==========================================================

      final isCompleted =
          doseNumber >= serie.requiredDoses;

      final updatedSerie = serie.copyWith(
        completedDoses: doseNumber,
        isCompleted: isCompleted,
      );

      final updateResult = await _serieService.update(
        updatedSerie.id!,
        updatedSerie.toMap(),
      );

      if (updateResult is Failure<void>) {
        return Failure(updateResult.message);
      }

      // ==========================================================
      // REFRESH RELATED PROVIDERS
      // ==========================================================

      ref.invalidate(
        healthCardProvider(request.petId),
      );

      ref.invalidate(
        vaccinationRecordProvider(request.petId),
      );

      ref.invalidate(
        vaccinationSerieProvider(request.petId),
      );

      return const Success(null);
    } catch (e) {
      return Failure(e.toString());
    }
  }
}