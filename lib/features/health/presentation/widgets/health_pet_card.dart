import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/features/health/domain/entity/health_record.dart';
import 'package:pet_care/features/pets/domain/entity/pet.dart';

class HealthPetCard extends StatelessWidget {
  final Pet pet;
  final List<HealthRecord> records;
  final VoidCallback onTap;

  const HealthPetCard({
    super.key,
    required this.pet,
    required this.records,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final meta = '${pet.breed} • ${_age(pet.birthDate)}';

    final String statusText;
    final Color statusTextColor;
    final Color statusBgColor;
    final IconData statusIcon;

    if (records.isEmpty) {
      statusText = 'No records yet';
      statusTextColor = const Color(0xFF94A3B8);
      statusBgColor = const Color(0xFFF1F5F9);
      statusIcon = Icons.description_outlined;
    } else {
      statusText = '${records.length} records';
      statusTextColor = const Color(0xFF0D9488);
      statusBgColor = const Color(0xFFE6FFFA);
      statusIcon = Icons.description_outlined;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(color: const Color(0xFFF1F5F9)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x060F172A),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            _Image(url: pet.photoUrl),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pet.name,
                    style: TextStyle(
                      fontSize: 15.5.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.text,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    meta,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.secondaryText,
                    ),
                  ),
                  SizedBox(height: 7.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                    decoration: BoxDecoration(
                      color: statusBgColor,
                      borderRadius: BorderRadius.circular(999.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(statusIcon, size: 12.sp, color: statusTextColor),
                        SizedBox(width: 4.w),
                        Text(
                          statusText,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: statusTextColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: const Color(0xFFCBD5E1),
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }

  String _age(DateTime birthDate) {
    final now = DateTime.now();
    var years = now.year - birthDate.year;
    if (DateTime(now.year, birthDate.month, birthDate.day).isAfter(now)) years--;
    return years > 0 ? '$years years' : 'Less than a year';
  }
}

class _Image extends StatelessWidget {
  final String url;
  const _Image({required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58.w,
      height: 58.w,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: url.isEmpty
          ? const Center(
              child: Icon(Icons.pets, color: AppColors.icon, size: 24),
            )
          : Image.network(
              url,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Center(
                child: Icon(Icons.pets, color: AppColors.icon, size: 24),
              ),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                  child: SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.primary,
                    ),
                  ),
                );
              },
            ),
    );
  }
}

