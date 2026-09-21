import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/core/constant/theme/app_style.dart';

import 'package:pet_care/features/authentication/presentation/helpers/helpers.dart';
import 'package:pet_care/features/health/vaccination/presentation/riverpod/health_card_privder.dart';
import 'package:pet_care/features/pets/riverpod/pet_provider.dart';
import 'package:pet_care/features/pets/widgets/Iinfo_card.dart';
import 'package:pet_care/features/pets/widgets/healt_card.dart';
import 'package:pet_care/features/pets/widgets/info_item.dart';
import 'package:pet_care/features/pets/widgets/pet_header.dart';

class PetDetailsScreen extends ConsumerStatefulWidget {
  final String petId;

  const PetDetailsScreen({
    super.key,
    required this.petId,
  });

  @override
  ConsumerState<PetDetailsScreen> createState() =>
      _PetDetailsScreenState();
}

class _PetDetailsScreenState
    extends ConsumerState<PetDetailsScreen> {

  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    final healthCardInfoState =
        ref.watch(healthCardProvider(widget.petId));

    final petsState = ref.watch(petProvider);

    return petsState.when(
      loading: () => const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),

      error: (error, stack) => Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              error.toString(),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),

      data: (pets) {
        final matchingPets = pets.where(
          (pet) => pet.id == widget.petId,
        );

        if (matchingPets.isEmpty) {
          return const Scaffold(
            backgroundColor: AppColors.background,
            body: Center(
              child: Text('Pet not found'),
            ),
          );
        }

        final pet = matchingPets.first;

        return Scaffold(
          backgroundColor: AppColors.background,

          appBar: AppBar(
            backgroundColor: AppColors.background,
            elevation: 0,
            scrolledUnderElevation: 0,

            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 20,
                color: AppColors.text,
              ),
              onPressed: () => Navigator.pop(context),
            ),

            title: Text(
              'Pet Details',
              style: AppStyle.tileTitle,
            ),

            centerTitle: true,
          ),

          body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              20,
              12,
              20,
              32,
            ),

            child: Column(
              children: [
                PetHeader(pet: pet),

                const SizedBox(height: 28),

                InfoCard(
                  title: 'Basic Information',
                  icon: Icons.pets_rounded,
                  children: [
                    InfoItem(
                      label: 'Species',
                      value: pet.species,
                    ),

                    InfoItem(
                      label: 'Gender',
                      value: pet.gender,
                    ),

                    InfoItem(
                      label: 'Breed',
                      value: pet.breed,
                    ),

                    InfoItem(
                      label: 'Weight',
                      value: '${pet.weight} kg',
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                InfoCard(
                  title: 'Notes',
                  icon: Icons.notes_rounded,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        pet.medicalNotes,
                        style: AppStyle.regular14,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                healthCardInfoState.when(
                  loading: () => const SizedBox(
                    height: 150,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),

                  error: (error, stack) => SizedBox(
                    height: 150,
                    child: Center(
                      child: Text(
                        error.toString(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),

                  data: (cardInfo) {
                    return HealthCard(
                      cardInfo: cardInfo,
                      petId: pet.id,
                    );
                  },
                ),

                const SizedBox(height: 28),

                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: OutlinedButton.icon(
                    onPressed: _isDeleting
                        ? null
                        : () async {
                            setState(() {
                              _isDeleting = true;
                            });

                            final result = await ref
                                .read(petProvider.notifier)
                                .deletePet(pet.id);

                            if (!context.mounted) {
                              return;
                            }

                            if (result is Success) {
                              Navigator.pop(context);
                              return;
                            }

                            setState(() {
                              _isDeleting = false;
                            });

                            if (result is Failure) {
                              showNotification(
                                context,
                                result.message,
                                success: false,
                              );
                            }
                          },

                    icon: _isDeleting
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : const Icon(
                            Icons.delete_outline_rounded,
                            size: 20,
                          ),

                    label: Text(
                      _isDeleting
                          ? 'Deleting...'
                          : 'Delete Pet',
                      style: AppStyle.buttonText.copyWith(
                        color: AppColors.error,
                      ),
                    ),

                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.error,
                      backgroundColor:
                          AppColors.error.withOpacity(0.08),
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
