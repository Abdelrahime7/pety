import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/features/health/vaccination/presentation/riverpod/all_vaccination_records_provider.dart';
import 'package:pet_care/features/health/vaccination/presentation/widgets/owner_vaccination_card.dart';
import 'package:pet_care/features/health/vaccination/presentation/widgets/vaccination_empty_state.dart';
import 'package:pet_care/features/health/vaccination/presentation/widgets/vaccination_filter.dart';
import 'package:pet_care/features/health/vaccination/presentation/widgets/vaccination_summary.dart';
import 'package:pet_care/features/pets/domain/entity/pet.dart';
import 'package:pet_care/features/pets/riverpod/pet_provider.dart';


class AllVaccinationsScreen extends ConsumerStatefulWidget {
  const AllVaccinationsScreen({super.key});

  @override
  ConsumerState<AllVaccinationsScreen> createState() =>
      _AllVaccinationsScreenState();
}

class _AllVaccinationsScreenState
    extends ConsumerState<AllVaccinationsScreen> {
  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    final vaccinationsAsync = ref.watch(allVaccinationRecordsProvider);
    final petsAsync = ref.watch(petProvider);

    final petNames = <String, String>{
      for (final pet in petsAsync.valueOrNull ?? <Pet>[])
        pet.id: pet.name,
    };

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'All Vaccinations',
          style: TextStyle(
            color: AppColors.text,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.text),
      ),
      body: vaccinationsAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
        error: (error, stackTrace) {

          return
           _OwnerVaccinationError(
          onRetry: () => ref.invalidate(allVaccinationRecordsProvider),
        );},
        data: (vaccinations) {
          final filtered = _selectedFilter == 'All'
              ? vaccinations
              : vaccinations
                  .where((record) =>
                      (petNames[record.petId] ?? 'Unknown pet') ==
                      _selectedFilter)
                  .toList();

          final petFilters = petNames.values.toSet().toList()..sort();

          return RefreshIndicator(
            color: AppColors.primary,
            onRefresh: () async {
              ref.invalidate(allVaccinationRecordsProvider);
              ref.invalidate(petProvider);
            },
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
              children: [
                OwnerVaccinationSummary(
                  total: vaccinations.length,
                  petCount: vaccinations.map((r) => r.petId).toSet().length,
                ),
                const SizedBox(height: 20),
                OwnerVaccinationFilterChips(
                  selected: _selectedFilter,
                  petNames: petFilters,
                  onSelected: (value) =>
                      setState(() => _selectedFilter = value),
                ),
                const SizedBox(height: 16),
                if (filtered.isEmpty)
                  const OwnerVaccinationEmptyState()
                else
                  ...filtered.map(
                    (record) => OwnerVaccinationCard(
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

class _OwnerVaccinationError extends StatelessWidget {
  const _OwnerVaccinationError({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.cloud_off_outlined,
                size: 42, color: AppColors.error),
            const SizedBox(height: 12),
            const Text(
              'Unable to load vaccinations.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.text, fontSize: 15),
            ),
            const SizedBox(height: 10),
            TextButton(onPressed: onRetry, child: const Text('Try again')),
          ],
        ),
      ),
    );
  }
}