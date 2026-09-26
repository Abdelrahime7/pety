import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/features/health/domain/entity/health_record.dart';
import 'package:pet_care/features/health/presentation/riverpod/health_notifier.dart';

final healthRecordsProvider = AsyncNotifierProvider.family<
    HealthRecordsNotifier,
    List<HealthRecord>,
    String>(
  HealthRecordsNotifier.new,
);

final healthFilterProvider = StateProvider.autoDispose<String>((ref) => 'All');