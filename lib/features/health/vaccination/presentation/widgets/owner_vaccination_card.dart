import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/core/constant/theme/app_style.dart';
import 'package:pet_care/features/health/vaccination/domain/entities/vaccination_record.dart';

class OwnerVaccinationCard extends StatelessWidget {
  const OwnerVaccinationCard({
    super.key,
    required this.record,
    required this.petName,
  });

  final VaccinationRecord record;
  final String petName;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(.14),
              borderRadius: BorderRadius.circular(13.r),
            ),
            child: const Icon(Icons.vaccines_outlined, color: AppColors.tealDark),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(record.vaccineName, style: AppStyle.tileTitle),
                SizedBox(height: 4.h),
                Text(petName,
                    style: TextStyle(color: AppColors.secondaryText, fontSize: 12.sp)),
                SizedBox(height: 8.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 6.h,
                  children: [
                    _InfoPill(
                      icon: Icons.medication_outlined,
                      label: 'Dose ${record.doseNumber}',
                    ),
                    _InfoPill(
                      icon: Icons.calendar_today_outlined,
                      label: DateFormat('MMM d, yyyy').format(record.vaccinationDate),
                    ),
                  ],
                ),
                if ((record.notes ?? '').trim().isNotEmpty) ...[
                  SizedBox(height: 8.h),
                  Text(record.notes!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: AppColors.secondaryText, fontSize: 12.sp)),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoPill extends StatelessWidget {
  const _InfoPill({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12.sp, color: AppColors.secondaryText),
          SizedBox(width: 5.w),
          Text(label, style: TextStyle(fontSize: 10.sp, color: AppColors.secondaryText)),
        ],
      ),
    );
  }
}