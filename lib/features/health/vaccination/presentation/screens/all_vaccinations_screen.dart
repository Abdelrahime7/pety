import 'package:pet_care/core/constant/theme/context_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pet_care/features/health/vaccination/presentation/riverpod/all_vaccination_records_provider.dart';
import 'package:pet_care/features/health/vaccination/presentation/widgets/owner_vaccination_card.dart';
import 'package:pet_care/features/health/vaccination/presentation/widgets/vaccination_empty_state.dart';
import 'package:pet_care/features/health/vaccination/presentation/widgets/vaccination_filter.dart';
import 'package:pet_care/features/health/vaccination/presentation/widgets/vaccination_summary.dart';
import 'package:pet_care/features/pets/domain/entity/pet.dart';
import 'package:pet_care/features/pets/riverpod/pet_provider.dart';

import 'package:pet_care/core/constant/l10n/l10x.dart';
class AllVaccinationsScreen extends ConsumerStatefulWidget {
  const AllVaccinationsScreen({super.key});

  @override
  ConsumerState<AllVaccinationsScreen> createState() =>
      _AllVaccinationsScreenState();
}

class _AllVaccinationsScreenState extends ConsumerState<AllVaccinationsScreen> {
  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    final vaccinationsAsync = ref.watch(allVaccinationRecordsProvider);
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
        title: Text(
          context.l10n.allVaccinations,
          style: TextStyle(
            color: context.colors.onSurface,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        iconTheme: IconThemeData(color: context.colors.onSurface),
      ),
      body: vaccinationsAsync.when(
        loading: () => Center(
          child: CircularProgressIndicator(color: context.colors.primary),
        ),
        error: (error, stackTrace) {
          return _OwnerVaccinationError(
            onRetry: () => ref.invalidate(allVaccinationRecordsProvider),
          );
        },
        data: (vaccinations) {
          final filtered = _selectedFilter == 'All'
              ? vaccinations
              : vaccinations
                    .where(
                      (record) =>
                          (petNames[record.petId] ?? 'Unknown pet') ==
                          _selectedFilter,
                    )
                    .toList();

          final petFilters = petNames.values.toSet().toList()..sort();

          return RefreshIndicator(
            color: context.colors.primary,
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
                      petName: petNames[record.petId] ?? context.l10n.pet,
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
            Icon(
              Icons.cloud_off_outlined,
              size: 42,
              color: context.colors.error,
            ),
            const SizedBox(height: 12),
            Text(
              context.l10n.unableToLoadVaccinations,
              textAlign: TextAlign.center,
              style: TextStyle(color: context.colors.onSurface, fontSize: 15),
            ),
            const SizedBox(height: 10),
            TextButton(onPressed: onRetry, child: Text(context.l10n.tryAgain)),
          ],
        ),
      ),
    );
  }
}