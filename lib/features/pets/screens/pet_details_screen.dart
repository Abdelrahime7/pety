import 'package:pet_care/core/constant/theme/context_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pet_care/core/constant/result/result.dart';

import 'package:pet_care/features/authentication/presentation/helpers/helpers.dart';
import 'package:pet_care/features/health/vaccination/presentation/riverpod/health_card_privder.dart';
import 'package:pet_care/features/pets/domain/entity/pet.dart';
import 'package:pet_care/features/pets/riverpod/pet_provider.dart';
import 'package:pet_care/features/pets/widgets/Iinfo_card.dart';
import 'package:pet_care/features/pets/widgets/healt_card.dart';
import 'package:pet_care/features/pets/widgets/info_item.dart';
import 'package:pet_care/features/pets/widgets/pet_header.dart';

import 'package:pet_care/core/constant/l10n/l10x.dart';
import 'package:pet_care/core/constant/l10n/display_labels.dart';
class PetDetailsScreen extends ConsumerStatefulWidget {
  final Pet pet;

  const PetDetailsScreen({super.key, required this.pet});

  @override
  ConsumerState<PetDetailsScreen> createState() => _PetDetailsScreenState();
}

class _PetDetailsScreenState extends ConsumerState<PetDetailsScreen> {
  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    final healthCardInfoState = ref.watch(healthCardProvider(widget.pet.id));

    return Scaffold(
      backgroundColor: context.colors.surface,

      appBar: AppBar(
        backgroundColor: context.colors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,

        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
            color: context.colors.onSurface,
          ),
          onPressed: () => Navigator.pop(context),
        ),

        title: Text(context.l10n.petDetails, style: context.style.tileTitle),

        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),

        child: Column(
          children: [
            PetHeader(pet: widget.pet),

            const SizedBox(height: 28),

            InfoCard(
              title: context.l10n.basicInformation,
              icon: Icons.pets_rounded,
              children: [
                InfoItem(label: context.l10n.species, value: speciesLabel(context.l10n, widget.pet.species)),

                InfoItem(label: context.l10n.gender, value: genderLabel(context.l10n, widget.pet.gender)),

                InfoItem(label: context.l10n.breed, value: widget.pet.breed),

                InfoItem(label: context.l10n.weight, value: '${widget.pet.weight} ${context.l10n.unitKg}'),
              ],
            ),

            const SizedBox(height: 16),

            InfoCard(
              title: context.l10n.notes,
              icon: Icons.notes_rounded,
              children: [
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    widget.pet.medicalNotes,
                    style: context.style.regular14,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            healthCardInfoState.when(
              loading: () => const SizedBox(
                height: 150,
                child: Center(child: CircularProgressIndicator()),
              ),

              error: (error, stack) => SizedBox(
                height: 150,
                child: Center(
                  child: Text(error.toString(), textAlign: TextAlign.center),
                ),
              ),

              data: (cardInfo) {
                return HealthCard(cardInfo: cardInfo, petId: widget.pet.id);
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
                            .deletePet(widget.pet.id);

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
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.delete_outline_rounded, size: 20),

                label: Text(
                  _isDeleting ? context.l10n.deleting : context.l10n.deletePet,
                  style: context.style.buttonText.copyWith(
                    color: context.colors.error,
                  ),
                ),

                style: OutlinedButton.styleFrom(
                  foregroundColor: context.colors.error,
                  backgroundColor: context.colors.error.withValues(alpha: 0.08),
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
  }
}