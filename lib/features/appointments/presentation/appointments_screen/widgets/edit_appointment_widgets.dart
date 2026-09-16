import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/features/pets/domain/entity/pet.dart';

class EditingPetHeader extends StatelessWidget {
  final Pet? pet;

  const EditingPetHeader({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: const Border(left: BorderSide(color: AppColors.primary, width: 4))),
      child: Row(
        children: [
          EditPetImage(url: pet?.photoUrl ?? ''),
          const SizedBox(width: 12),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: const Color(0xFFE4FBF7), borderRadius: BorderRadius.circular(8)), child: const Text('Editing', style: TextStyle(fontSize: 10, color: AppColors.tealDark, fontWeight: FontWeight.w700))),
            const SizedBox(height: 5),
            Text(pet?.name ?? 'Pet', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
            Text(pet == null ? 'Pet details unavailable' : pet!.breed, style: const TextStyle(fontSize: 11, color: AppColors.secondaryText)),
          ]),
        ],
      ),
    );
  }
}

class EditPetSelector extends StatelessWidget {
  final List<Pet> pets;
  final String selectedPetId;
  final ValueChanged<String> onSelected;

  const EditPetSelector({super.key, required this.pets, required this.selectedPetId, required this.onSelected});

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
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), border: Border.all(color: selected ? AppColors.primary : Colors.transparent, width: 2)),
                  child: ClipRRect(borderRadius: BorderRadius.circular(12), child: EditPetImage(url: pet.photoUrl, fit: BoxFit.cover)),
                ),
                const SizedBox(height: 4),
                Text(pet.name, style: TextStyle(fontSize: 10, color: selected ? AppColors.text : AppColors.secondaryText)),
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
      decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(14)),
      child: url.isEmpty ? const Icon(Icons.pets, color: AppColors.icon) : Image.network(url, fit: fit, errorBuilder: (_, _, _) => const Icon(Icons.pets, color: AppColors.icon)),
    );
  }
}
