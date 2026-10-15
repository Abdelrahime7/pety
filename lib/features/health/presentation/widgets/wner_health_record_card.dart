import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/core/constant/theme/app_style.dart';
import 'package:pet_care/features/health/domain/entity/health_record.dart';

class OwnerHealthRecordCard extends StatelessWidget {
  const OwnerHealthRecordCard({super.key, required this.record, required this.petName});

  final HealthRecord record;
  final String petName;

  IconData _iconForType(String type) {
    switch (type.toLowerCase()) {
      case 'vaccination':
        return Icons.vaccines_outlined;
      case 'medication':
        return Icons.medication_outlined;
      case 'allergy':
        return Icons.warning_amber_rounded;
      case 'surgery':
        return Icons.medical_services_outlined;
      case 'checkup':
        return Icons.health_and_safety_outlined;
      default:
        return Icons.folder_open_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final typeName = record.type.name;
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
            child: Icon(_iconForType(typeName), color: AppColors.tealDark),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(record.title, style: AppStyle.tileTitle),
                SizedBox(height: 4.h),
                Text(petName,
                    style: TextStyle(color: AppColors.secondaryText, fontSize: 12.sp)),
                SizedBox(height: 8.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 6.h,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 5.h),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(.12),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        typeName[0].toUpperCase() + typeName.substring(1),
                        style: TextStyle(color: AppColors.tealDark, fontSize: 11.sp, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Text(
                      DateFormat('MMM d, yyyy').format(record.date),
                      style: TextStyle(color: AppColors.secondaryText, fontSize: 11.sp),
                    ),
                  ],
                ),
                if ((record.notes).trim().isNotEmpty) ...[
                  SizedBox(height: 8.h),
                  Text(
                    record.notes,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: AppColors.secondaryText, fontSize: 12.sp),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}