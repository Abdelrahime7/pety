import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/core/dependencies%20inection/di.dart';
import 'package:pet_care/core/services/health_service.dart';
import 'package:pet_care/features/health/domain/entity/health_record.dart';

class HealthRecordsNotifier
    extends FamilyAsyncNotifier<List<HealthRecord>, String> {
  HealthService get _service => ref.read(healthServiceProvider);

  @override
  FutureOr<List<HealthRecord>> build(String arg) async {
    final result = await _service.getRecords(arg);
    if (result is Success<List<HealthRecord>>) {
      return result.data;
    }
    if (result is Failure<List<HealthRecord>>) {
      throw Exception(result.message);
    }
    return [];
  }

  Future<void> refreshRecords() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final result = await _service.getRecords(arg);
      if (result is Success<List<HealthRecord>>) {
        return result.data;
      }
      throw Exception(
        result is Failure
            ? (result as Failure).message
            : 'Unable to load health records.',
      );
    });
  }
}
