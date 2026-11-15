import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/core/dependencies_injection/di.dart';
import 'package:pet_care/features/health/vaccination/domain/entities/helath_card_info.dart';

class HealthCardInfoNotifier
    extends FamilyAsyncNotifier<HealthCardInfo, String> {

  @override
  Future<HealthCardInfo> build(String petId) async {
    final ownerId = FirebaseAuth.instance.currentUser?.uid;

    if (ownerId == null) {
      throw Exception('User is not authenticated.');
    }

    final vaccinationRecordService =
        ref.read(vaccinationRecordServiceProvider);

    final vaccinationSerieService =
        ref.read(vaccinationSerieServiceProvider);

    final recordsResult = await vaccinationRecordService.count(
      
      petId,
      ownerId
    );

    final seriesResult = await vaccinationSerieService.countActivSeries(
      petId,
      ownerId
    );

    if (recordsResult is Failure<int>) {
      throw recordsResult.message;
    }

    if (seriesResult is Failure<int>) {
      throw seriesResult.message;
    }

    final doseCount = (recordsResult as Success<int>).data;
    final activeSeriesCount = (seriesResult as Success<int>).data;

    return HealthCardInfo(
      vaccination: VaccinationItemInfo(
        doseCount: doseCount,
        activeSeriesCount: activeSeriesCount,
      ),
      appointment: AppointmentItemInfo(
        appointmentCount: 0,
        nextDueDate: null,
      ),
    );
  }
}