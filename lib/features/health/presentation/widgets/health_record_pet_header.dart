import 'package:pet_care/core/constant/theme/context_x.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pet_care/features/pets/domain/entity/pet.dart';

import 'package:pet_care/core/constant/l10n/l10x.dart';
class HealthRecordPetHeader extends StatelessWidget {
  final Pet pet;

  const HealthRecordPetHeader({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainer,
        borderRadius: BorderRadius.circular(16.r),
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
          Container(
            width: 48.w,
            height: 48.w,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: context.colors.outlineVariant,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: pet.photoUrl.isEmpty
                ? Icon(
                    Icons.pets,
                    color: context.colors.onSurfaceVariant,
                    size: 23.sp,
                  )
                : Image.network(
                    pet.photoUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.pets,
                        color: context.colors.onSurfaceVariant,
                        size: 23.sp,
                      );
                    },
                  ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.addingRecordFor.toUpperCase(),
                  style: TextStyle(
                    fontSize: 9.5.sp,
                    fontWeight: FontWeight.w700,
                    color: context.colors.onSurfaceVariant,
                    letterSpacing: context.tracking(0.6),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  pet.name,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                    color: context.colors.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}