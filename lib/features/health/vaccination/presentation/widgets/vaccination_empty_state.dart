import 'package:pet_care/core/constant/theme/context_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';

import 'package:pet_care/core/constant/l10n/l10x.dart';
class OwnerVaccinationEmptyState extends StatelessWidget {
  const OwnerVaccinationEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 54.h, horizontal: 20.w),
      child: Column(
        children: [
          Container(
            width: 64.w,
            height: 64.w,
            decoration:  BoxDecoration(
              color: context.colors.primary.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.vaccines_outlined,
              size: 30,
              color: AppColors.tealDark,
            ),
          ),
          SizedBox(height: 14.h),
          Text(context.l10n.noVaccinationsYet, style: context.style.sectionHeader),
          SizedBox(height: 6.h),
          Text(
            context.l10n.vaccinationRecordsWillAppear,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              color: context.colors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}