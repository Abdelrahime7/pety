import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/core/constant/theme/context_x.dart';

import 'package:pet_care/features/health/presentation/riverpod/all_Health_Records_Provider.dart';
import 'package:pet_care/features/health/presentation/widgets/health_record_filters.dart';
import 'package:pet_care/features/health/presentation/widgets/health_records_empty_state.dart';
import 'package:pet_care/features/health/presentation/widgets/health_records_summary.dart';
import 'package:pet_care/features/health/presentation/widgets/wner_health_record_card.dart';
import 'package:pet_care/features/pets/domain/entity/pet.dart';
import 'package:pet_care/features/pets/riverpod/pet_provider.dart';

class AllHealthRecordsScreen extends ConsumerStatefulWidget {
  const AllHealthRecordsScreen({super.key});

  @override
  ConsumerState<AllHealthRecordsScreen> createState() =>
      _AllHealthRecordsScreenState();
}

class _AllHealthRecordsScreenState
    extends ConsumerState<AllHealthRecordsScreen> {
  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    final recordsAsync = ref.watch(allHealthRecordsProvider);
    final petsAsync = ref.watch(petProvider);

    final petNames = <String, String>{
      for (final pet in petsAsync.valueOrNull ?? <Pet>[]) pet.id: pet.name,
    };

    return Scaffold(
      backgroundColor: context.colors.surface,
      appBar: AppBar(
        backgroundColor: context.colors.surface,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: context.colors.onSurface),
        title: Text(
          'All Health Records',
          style: TextStyle(
            color: context.colors.onSurface,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: recordsAsync.when(
        loading: () => Center(
          child: CircularProgressIndicator(color: context.colors.primary),
        ),
        error: (error, stackTrace) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.cloud_off_outlined,
                  size: 42,
                  color: context.colors.error,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Unable to load health records.',
                  textAlign: TextAlign.center,
                ),
                TextButton(
                  onPressed: () => ref.invalidate(allHealthRecordsProvider),
                  child: const Text('Try again'),
                ),
              ],
            ),
          ),
        ),
        data: (records) {
          final filtered = _selectedFilter == 'All'
              ? records
              : records
                    .where(
                      (r) =>
                          r.type.name.toLowerCase() ==
                          _selectedFilter.toLowerCase(),
                    )
                    .toList();

          return RefreshIndicator(
            color: context.colors.primary,
            onRefresh: () async {
              ref.invalidate(allHealthRecordsProvider);
              ref.invalidate(petProvider);
            },
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
              children: [
                OwnerHealthRecordsSummary(
                  total: records.length,
                  petCount: records.map((r) => r.petId).toSet().length,
                ),
                const SizedBox(height: 20),
                OwnerHealthRecordFilterChips(
                  selected: _selectedFilter,
                  onSelected: (value) =>
                      setState(() => _selectedFilter = value),
                ),
                const SizedBox(height: 16),
                if (filtered.isEmpty)
                  const OwnerHealthRecordsEmptyState()
                else
                  ...filtered.map(
                    (record) => OwnerHealthRecordCard(
                      record: record,
                      petName: petNames[record.petId] ?? 'Pet',
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
