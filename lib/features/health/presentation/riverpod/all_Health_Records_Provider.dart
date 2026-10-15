import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/core/dependencies%20inection/di.dart';
import 'package:pet_care/features/health/domain/entity/health_record.dart';

final allHealthRecordsProvider =
    FutureProvider<List<HealthRecord>>((ref) async {
  final ownerId = FirebaseAuth.instance.currentUser?.uid;

  if (ownerId == null) {
    return [];
  }

  final healthService = ref.watch(healthServiceProvider);

  final result = await healthService.getAllRecords(ownerId);

  switch (result) {
    case Success<List<HealthRecord>>():
      return result.data;

    case Failure<List<HealthRecord>>():
      throw Exception(result.message);

    case Cancelled<List<HealthRecord>>():
      return [];
  }
});