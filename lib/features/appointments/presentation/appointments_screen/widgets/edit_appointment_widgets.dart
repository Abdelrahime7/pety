import 'package:pet_care/core/constant/theme/context_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/features/pets/domain/entity/pet.dart';

import 'package:pet_care/core/constant/l10n/l10x.dart';
class EditingPetHeader extends StatelessWidget {
  final Pet? pet;

  const EditingPetHeader({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainer,
        borderRadius: BorderRadius.circular(18),
        border: BorderDirectional(
          start: BorderSide(color: context.colors.primary, width: 4),
        ),
      ),
      child: Row(
        children: [
          EditPetImage(url: pet?.photoUrl ?? ''),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: context.colors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  context.l10n.editing,
                  style: TextStyle(
                    fontSize: 10,
                    color:context.colors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                pet?.name ?? context.l10n.pet,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                pet == null ? context.l10n.petDetailsUnavailable : pet!.breed,
                style: TextStyle(
                  fontSize: 11,
                  color: context.colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class EditPetSelector extends StatelessWidget {
  final List<Pet> pets;
  final String selectedPetId;
  final ValueChanged<String> onSelected;

  const EditPetSelector({
    super.key,
    required this.pets,
    required this.selectedPetId,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 94.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: pets.length,
        separatorBuilder: (_, _) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          final pet = pets[index];
          final selected = pet.id == selectedPetId;
          return GestureDetector(
            onTap: () => onSelected(pet.id),
            child: Column(
              children: [
                Container(
                  width: 58.w,
                  height: 58.w,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: selected
                          ? context.colors.primary
                          : context.colors.surface,
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: EditPetImage(url: pet.photoUrl, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  pet.name,
                  style: TextStyle(
                    fontSize: 10,
                    color: selected
                        ? context.colors.onSurface
                        : context.colors.onSurfaceVariant,
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

class EditPetImage extends StatelessWidget {
  final String url;
  final BoxFit fit;

  const EditPetImage({super.key, required this.url, this.fit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 54,
      height: 54,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: context.colors.outlineVariant,
        borderRadius: BorderRadius.circular(14),
      ),
      child: url.isEmpty
          ? Icon(Icons.pets, color: context.colors.onSurfaceVariant)
          : Image.network(
              url,
              fit: fit,
              errorBuilder: (_, _, _) =>
                  Icon(Icons.pets, color: context.colors.onSurfaceVariant),
            ),
    );
  }
}