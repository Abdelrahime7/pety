import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/infrastructure/firebase/health/firebase_health_data_source.dart';
import 'package:pet_care/features/health/domain/entity/health_record.dart';

class HealthService {
  final FirebaseHealthDataSource dataSource;

  HealthService({required this.dataSource});

  Future<Result<List<HealthRecord>>> getRecords(String petId) async {
    try {
      final docs = await dataSource.getRecords(petId);
      final records = docs.map(HealthRecord.fromFirestore).toList()
        ..sort((a, b) => b.date.compareTo(a.date));
      return Success(records);
    } on FirebaseException catch (error) {
      return Failure(error.message ?? 'Unable to load health records.');
    } catch (_) {
      return const Failure('Unable to load health records.');
    }
  }
}
