


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/core/dependencies%20inection/di.dart';
import 'package:pet_care/features/health/vaccination/domain/entities/helath_card_info.dart';

class HealthCardInfoNotifier
    extends FamilyAsyncNotifier<HealthCardInfo, String> {

  @override
  Future<HealthCardInfo> build(String petId) async {
    final vaccinationRecordService =
        ref.read(vaccinationRecordServiceProvider);

    final vaccinationSerieService =
        ref.read(vaccinationSerieServiceProvider);

    final recordsResult =
        await vaccinationRecordService.count(petId);

    final seriesResult =
        await vaccinationSerieService.countActivSeries(petId);

    if (recordsResult is Failure<int>) {
      throw recordsResult.message;
    }

    if (seriesResult is Failure<int>) {
      throw seriesResult.message;
    }

    final doseCount = (recordsResult as Success<int>).data;
    final activeSeriesCount =
        (seriesResult as Success<int>).data;

    final vaccinationItemInfo = VaccinationItemInfo(
      doseCount: doseCount,
      activeSeriesCount: activeSeriesCount,
    );

    final appointmentItemInfo = AppointmentItemInfo(
      appointmentCount: 0,
      nextDueDate: null,
    );

    return HealthCardInfo(
      vaccination: vaccinationItemInfo,
      appointment: appointmentItemInfo,
    );
  }
}
