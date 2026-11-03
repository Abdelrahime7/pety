import 'package:pet_care/core/constant/theme/context_x.dart';

import 'package:flutter/material.dart';
import 'package:pet_care/core/constant/routers/app_routers.dart';
import 'package:pet_care/features/pets/domain/entity/pet.dart';
import 'package:pet_care/core/constant/routers/routes_strings.dart';

import 'package:pet_care/core/constant/l10n/l10x.dart';
class PetHeader extends StatelessWidget {
  final Pet pet;

  const PetHeader({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 130,
          height: 130,
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius: BorderRadius.circular(40),
          ),
          clipBehavior: Clip.antiAlias,
          child: pet.photoUrl.isNotEmpty
              ? Image.network(
                  pet.photoUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) {
                    return Icon(
                      Icons.pets_rounded,
                      size: 48,
                      color: context.colors.onSurfaceVariant,
                    );
                  },
                )
              : Icon(
                  Icons.pets_rounded,
                  size: 48,
                  color: context.colors.onSurfaceVariant,
                ),
        ),

        const SizedBox(height: 16),

        Text(pet.name, style: context.style.title),

        const SizedBox(height: 5),

        Text(pet.breed, style: context.style.regular14),

        const SizedBox(height: 18),

        SizedBox(
          height: 42,
          child: OutlinedButton.icon(
            onPressed: () {
              appRouter.push(petEdit, extra: pet);
            },
            icon: const Icon(Icons.edit_rounded, size: 16),
            label: Text(
              context.l10n.editPet,
              style: context.style.buttonText.copyWith(
                color: context.colors.onSurface,
              ),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: context.colors.onSurface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),
      ],
    );
  }
}