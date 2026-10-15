import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/core/constant/theme/app_style.dart';

class HealthSummarySection extends StatelessWidget {
  const HealthSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        children: [
          _HealthSummaryRow(
            icon: Icons.vaccines_outlined,
            iconColor: const Color(0xFF0D9488),
            iconBackground: const Color(0xFFE0F7F3),
            title: 'Vaccinations',
            subtitle: 'Keep track of vaccine doses',
            status: 'View',
            onTap: () {
              // TODO: Navigate to vaccination records.
            },
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 14.h),
            child: Divider(
              height: 1,
              color: AppColors.border,
            ),
          ),

          _HealthSummaryRow(
            icon: Icons.medical_services_outlined,
            iconColor: const Color(0xFF6366F1),
            iconBackground: const Color(0xFFEEF2FF),
            title: 'Medical History',
            subtitle: 'Check your pet’s health records',
            status: 'View',
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
            child: Icon(
              icon,
              size: 22.sp,
              color: iconColor,
            ),
          ),

          SizedBox(width: 12.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppStyle.tileTitle.copyWith(
                    fontSize: 13.sp,
                  ),
                ),

                SizedBox(height: 4.h),

                Text(
                  subtitle,
                  style: AppStyle.regular10,
                ),
              ],
            ),
          ),

          Text(
            status,
            style: AppStyle.buttonText.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.tealDark,
            ),
          ),

          SizedBox(width: 4.w),

          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 13.sp,
            color: AppColors.icon,
          ),
        ],
      ),
    );
  }
}