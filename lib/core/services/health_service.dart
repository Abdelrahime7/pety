import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/infrastructure/firebase/health/firebase_health_data_source.dart';
import 'package:pet_care/features/health/domain/entity/health_record.dart';

class HealthService {
  final FirebaseHealthDataSource dataSource;

  HealthService({required this.dataSource});

  // Get health records for one pet.
  Future<Result<List<HealthRecord>>> getRecords(String petId) async {
    try {
      final docs = await dataSource.getPetRecords(petId);

      final records = docs.map(HealthRecord.fromFirestore).toList()
        ..sort((a, b) => b.date.compareTo(a.date));

      return Success(records);
    } on FirebaseException catch (error) {
      return Failure(error.message ?? 'Unable to load health records.');
    } catch (_) {
      return const Failure('Unable to load health records.');
    }
  }

  // Get health records for all pets belonging to a user.
  Future<Result<List<HealthRecord>>> getAllRecords(String ownerId) async {
    try {
      final docs = await dataSource.getAllRecords(ownerId);

      final records = docs.map(HealthRecord.fromFirestore).toList()
        ..sort((a, b) => b.date.compareTo(a.date));

      return Success(records);
    } on FirebaseException catch (error) {
      return Failure(error.message ?? 'Unable to load health records.');
    } catch (_) {
      return const Failure('Unable to load health records.');
    }
  }

  // Create a health record.
  Future<Result<void>> createRecord(HealthRecord record) async {
    try {
      await dataSource.createRecord(record);

      return const Success(null);
    } on FirebaseException catch (error) {
      return Failure(error.message ?? 'Unable to add health record.');
    } catch (_) {
      return const Failure('Unable to add health record.');
    }
  }
}