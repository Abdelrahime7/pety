import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/features/pets/domain/entity/pet.dart';

class PetCard extends StatelessWidget {
  final Pet pet;
  final VoidCallback onTap;

  const PetCard({
    super.key,
    required this.pet,
    required this.onTap,
  });

  String _calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    int years = now.year - birthDate.year;
    int months = now.month - birthDate.month;
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      years--;
      months += 12;
    }
    if (years > 0) return '$years years';
    if (months > 0) return '$months months';
    
     return 'Less than a month';
    
  }

  @override
  Widget build(BuildContext context) {
    final ageStr = _calculateAge(pet.birthDate);
    
    // Changing standard to show Gender based on allowed data model
    final genderText = pet.gender;
    final isMale = genderText.toLowerCase() == 'male';
    
    // Color coding gender playfully
    final tagBgColor = isMale ? const Color(0xFFF0FDFA) : const Color(0xFFFFF1F2);
    final tagTextColor = isMale ? const Color(0xFF0F766E) : const Color.fromARGB(255, 187, 122, 149);
    
    final inkMuted = const Color(0xFF64748B);
    final inkSoft = const Color(0xFF94A3B8);
    final ink = const Color(0xFF0F172A);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: const Color(0xFFF1F5F9)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            // Image Stack
            SizedBox(
              width: 80.w,
              height: 80.w,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 80.w,
                    height: 80.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      color: const Color(0xFFF1F5F9),
                      image: pet.photoUrl.isNotEmpty
                          ? DecorationImage(
                              image: NetworkImage(pet.photoUrl),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: pet.photoUrl.isEmpty
                        ? Icon(Icons.pets, color: inkSoft)
                        : null,
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.w),
            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        pet.name,
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w600,
                          color: ink,
                        ),
                      ),
                      Icon(Icons.chevron_right, color: inkSoft, size: 16.sp),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${pet.breed} • $ageStr',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: inkMuted,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      // Status Tag
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: tagBgColor,
                          borderRadius: BorderRadius.circular(999.r), // full rounded
                        ),
                        child: Text(
                          genderText,
                          style: TextStyle(
                            color: tagTextColor,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      // Weight Tag
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9), // slate-100
                          borderRadius: BorderRadius.circular(999.r),
                        ),
                        child: Text(
                          '${pet.weight} lbs',
                          style: TextStyle(
                            color: inkMuted,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
