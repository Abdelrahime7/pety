
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pet_care/core/constant/routers/app_routers.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/core/constant/theme/app_style.dart';
import 'package:pet_care/features/health/vaccination/presentation/riverpod/vaccination_providers.dart';
import 'package:pet_care/features/health/vaccination/presentation/widgets/vaccination_list_item.dart';

class VaccinationListScreen extends ConsumerWidget {
  final String petId;

  const VaccinationListScreen({
    super.key,
    required this.petId,
  });


  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vaccinationsAsync = ref.watch(
                      vaccinationSerieProvider(petId),
    

    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'Vaccinations',
          style: AppStyle.tileTitle.copyWith(
            fontSize: 20,
          ),
        ),
      ),
      body: vaccinationsAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),

        error: (error, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.error_outline_rounded,
                  size: 45,
                  color: Colors.redAccent,
                ),
                const SizedBox(height: 12),
                Text(
                  'Failed to load vaccinations',
                  style: AppStyle.tileTitle.copyWith(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                Text(
                  error.toString(),
                  style: AppStyle.regular10,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    ref.invalidate(
                      vaccinationSerieProvider(petId),
                    );
                  },
                  child: const Text('Try again'),
                ),
              ],
            ),
          ),
        ),

        data: (vaccinations) {
          if (vaccinations.isEmpty) {
            return _EmptyVaccinationState(
              onAdd: () {
                appRouter.push(
                  addVaccination,
                  extra: petId,
                );
              },
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              // ignore: unused_result
              await ref.refresh(
                      vaccinationSerieProvider(petId)
                .future,
              );
            },
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(
                16,
                16,
                16,
                100,
              ),
              itemCount: vaccinations.length,
              separatorBuilder: (_, __) => const SizedBox(
                height: 12,
              ),
              itemBuilder: (context, index) {
                final vaccination = vaccinations[index];


                return VaccinationListItem(
                  
                  vaccineName: vaccination.vaccineName,
                    requiredDoses:vaccination.requiredDoses,
                    completedDoses: vaccination.completedDoses,
                
                  onTap: () {
                    appRouter.push(vaccinationDetails,extra: vaccination);
                  },
                );
              },
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          appRouter.push(
            addVaccination,
            extra: petId,
          );
        },
        backgroundColor: AppColors.primary,
        child: const Icon(
          Icons.add_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _EmptyVaccinationState extends StatelessWidget {
  final VoidCallback onAdd;

  const _EmptyVaccinationState({
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(
                  alpha: 0.10,
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.vaccines_rounded,
                size: 38,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'No vaccinations yet',
              style: AppStyle.tileTitle.copyWith(
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Keep your pet healthy by adding their vaccinations.',
              style: AppStyle.regular10,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: onAdd,
              icon: const Icon(Icons.add_rounded),
              label: const Text('Add Vaccination'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
