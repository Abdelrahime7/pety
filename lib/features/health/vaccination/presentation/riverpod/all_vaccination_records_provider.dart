import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/core/dependencies%20inection/di.dart';
import 'package:pet_care/features/health/vaccination/domain/entities/vaccination_record.dart';

final allVaccinationRecordsProvider =
    FutureProvider<List<VaccinationRecord>>((ref) async {
  final ownerId = FirebaseAuth.instance.currentUser?.uid;

  if (ownerId == null) {
    return [];
  }

  final vaccinationDataSource = ref.watch(vaccinationDataSourceProvider);

  final result = await vaccinationDataSource.getAllOwnerVaccinations(
    ownerId,
    'vaccinationRecords',
  );

  switch (result) {
    case Success<List<QueryDocumentSnapshot<Map<String, dynamic>>>>():
      return result.data
          .map((doc) => VaccinationRecord.fromMap(doc.data()))
          .toList();

    case Failure<List<QueryDocumentSnapshot<Map<String, dynamic>>>>():
      throw Exception(result.message);

    case Cancelled<List<QueryDocumentSnapshot<Map<String, dynamic>>>>():
      return [];
  }
});