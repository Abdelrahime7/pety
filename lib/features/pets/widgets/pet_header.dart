 


import 'package:flutter/material.dart';
import 'package:pet_care/core/constant/routers/app_routers.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/core/constant/theme/app_style.dart';
import 'package:pet_care/features/pets/domain/entity/pet.dart';

class PetHeader extends StatelessWidget {
  final Pet pet;

  const PetHeader({
    required this.pet,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 130,
          height: 130,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(40),
          ),
          clipBehavior: Clip.antiAlias,
          child: pet.photoUrl.isNotEmpty
              ? Image.network(
                  pet.photoUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return const Icon(
                      Icons.pets_rounded,
                      size: 48,
                      color: AppColors.icon,
                    );
                  },
                )
              : const Icon(
                  Icons.pets_rounded,
                  size: 48,
                  color: AppColors.icon,
                ),
        ),

        const SizedBox(height: 16),

        Text(
          pet.name,
          style: AppStyle.title,
        ),

        const SizedBox(height: 5),

        Text(
          pet.breed,
          style: AppStyle.regular14,
        ),

        const SizedBox(height: 18),

        SizedBox(
          height: 42,
          child: OutlinedButton.icon(
            onPressed: () {
              appRouter.push(petEdit,extra: pet);
            },
            icon: const Icon(
              Icons.edit_rounded,
              size: 16,
            ),
            label: Text(
              'Edit Pet',
              style: AppStyle.buttonText.copyWith(
                color: AppColors.text,
              ),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.text,
              side: const BorderSide(
                color: AppColors.border,
              ),
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