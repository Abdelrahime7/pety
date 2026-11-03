import 'package:pet_care/core/constant/theme/context_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pet_care/core/constant/theme/app_colors.dart';

import 'package:pet_care/core/constant/l10n/l10x.dart';
class HealthSummarySection extends StatelessWidget {
  const HealthSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainer,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: context.colors.outlineVariant),
      ),
      child: Column(
        children: [
          _HealthSummaryRow(
            icon: Icons.vaccines_outlined,
            iconColor: context.colors.primary,
            iconBackground: context.colors.primary.withValues(alpha: 0.12),
            title: context.l10n.vaccinations,
            subtitle: context.l10n.keepTrackVaccineDoses,
            status: context.l10n.view,
            onTap: () {
              // TODO: Navigate to vaccination records.
            },
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 14.h),
            child: Divider(height: 1, color: context.colors.outlineVariant),
          ),

          _HealthSummaryRow(
            icon: Icons.medical_services_outlined,
            iconColor: const Color(0xFF6366F1),
            iconBackground: const Color(0xFFEEF2FF),
            title: context.l10n.medicalHistory,
            subtitle: context.l10n.checkPetHealthRecords,
            status: context.l10n.view,
            onTap: () {
              // TODO: Navigate to health records.
            },
          ),
        ],
      ),
    );
  }
}

class _HealthSummaryRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final String title;
  final String subtitle;
  final String status;
  final VoidCallback? onTap;

  const _HealthSummaryRow({
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.title,
    required this.subtitle,
    required this.status,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Row(
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: iconBackground,
              borderRadius: BorderRadius.circular(13.r),
            ),
            child: Icon(icon, size: 22.sp, color: iconColor),
          ),

          SizedBox(width: 12.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.style.tileTitle.copyWith(fontSize: 13.sp),
                ),

                SizedBox(height: 4.h),

                Text(subtitle, style: context.style.regular10),
              ],
            ),
          ),

          Text(
            status,
            style: context.style.buttonText.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.tealDark,
            ),
          ),

          SizedBox(width: 4.w),

          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 13.sp,
            color: context.colors.onSurfaceVariant,
          ),
        ],
      ),
    );
  }
}