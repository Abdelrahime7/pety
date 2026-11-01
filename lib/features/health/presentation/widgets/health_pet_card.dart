import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/core/constant/theme/context_x.dart';
import 'package:pet_care/features/pets/domain/entity/pet.dart';

class HealthPetCard extends StatelessWidget {
  final Pet pet;
  final VoidCallback onTap;

  const HealthPetCard({super.key, required this.pet, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final meta = '${pet.breed} • ${_age(pet.birthDate)}';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: context.colors.surfaceContainer,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(color: context.colors.outlineVariant),
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
                      color: context.colors.onSurface,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    meta,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: context.colors.onSurfaceVariant,
                    ),
                  ),
                  SizedBox(height: 7.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 3.h,
                    ),
                    decoration: BoxDecoration(
                      color: context.colors.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(999.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.monitor_heart_outlined,
                          size: 12.sp,
                          color: context.colors.primary,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'View records',
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: context.colors.primary,
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
              color: context.colors.outlineVariant,
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
    if (DateTime(now.year, birthDate.month, birthDate.day).isAfter(now))
      years--;
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
        color: context.colors.outlineVariant,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: url.isEmpty
          ? Center(
              child: Icon(
                Icons.pets,
                color: context.colors.onSurfaceVariant,
                size: 24,
              ),
            )
          : Image.network(
              url,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Center(
                child: Icon(
                  Icons.pets,
                  color: context.colors.onSurfaceVariant,
                  size: 24,
                ),
              ),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: context.colors.primary,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
