import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/core/constant/theme/app_style.dart';
import 'package:pet_care/features/home/presentation%20/widgets/pet_card.dart';
import 'package:pet_care/features/pets/domain/entity/pet.dart';

class HomePetsSection extends StatelessWidget {
  final List<Pet> pets;
  final ValueChanged<Pet>? onPetTap;
  final VoidCallback? onSeeAll;
  final VoidCallback? onAddPet;

  const HomePetsSection({
    super.key,
    required this.pets,
    this.onPetTap,
    this.onSeeAll,
    this.onAddPet,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Premium section heading
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 4.w,
                height: 30.h,
                decoration: BoxDecoration(
                  color: AppColors.tealDark,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),

              SizedBox(width: 10.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Companions',
                      style: AppStyle.sectionHeader.copyWith(
                        fontSize: 19.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      '${pets.length} ${pets.length == 1 ? 'beloved companion' : 'beloved companions'}',
                      style: AppStyle.regular12.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              if (pets.isNotEmpty)
                GestureDetector(
                  onTap: onSeeAll,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 9.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(30.r),
                      border: Border.all(
                        color: AppColors.border,
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'See all',
                          style: AppStyle.regular12.copyWith(
                            color: AppColors.tealDark,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 5.w),
                        Icon(
                          Icons.arrow_forward_rounded,
                          size: 14.sp,
                          color: AppColors.tealDark,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),

        SizedBox(height: 20.h),

        // Pets carousel
        if (pets.isEmpty)
          _buildEmptyState()
        else
          SizedBox(
            height: 160.h,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: pets.length,
              separatorBuilder: (_, _) => SizedBox(width: 15.w),
              itemBuilder: (context, index) {
                final pet = pets[index];

                return SizedBox(
                  width: 125.w,
                  child: HomePetCard(
                    pet: pet,
                    onTap: () => onPetTap?.call(pet),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(22.w),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: AppColors.tealDark.withOpacity(0.04),
              blurRadius: 20.r,
              offset: Offset(0, 8.h),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 66.w,
              height: 66.w,
              decoration: BoxDecoration(
                gradient: AppColors.premiumCardGradient,
                borderRadius: BorderRadius.circular(22.r),
              ),
              child: Icon(
                Icons.pets_rounded,
                color: Colors.white,
                size: 32.sp,
              ),
            ),

            SizedBox(height: 16.h),

            Text(
              'Every great story starts here',
              textAlign: TextAlign.center,
              style: AppStyle.tileTitle.copyWith(
                fontSize: 16.sp,
              ),
            ),

            SizedBox(height: 6.h),

            Text(
              'Add your first companion and give them '
              'the care they deserve.',
              textAlign: TextAlign.center,
              style: AppStyle.regular13.copyWith(
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),

            SizedBox(height: 18.h),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onAddPet,
                icon: const Icon(Icons.add_rounded),
                label: const Text('Add your first pet'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(vertical: 13.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
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