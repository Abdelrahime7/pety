import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/features/health/vaccination/domain/entities/vaccination_record.dart';

class VaccinationRecordCard extends StatelessWidget {
  final VaccinationRecord record;
  final VoidCallback onTap;

  const VaccinationRecordCard({
    super.key,
    required this.record,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: const Color(0xFFF1F5F9),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: const Color(0xFFE6FFFA),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.vaccines_outlined,
                color: AppColors.primary,
                size: 22.sp,
              ),
            ),

            SizedBox(width: 12.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    record.vaccineName,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.text,
                    ),
                  ),

                  SizedBox(height: 4.h),

                  Text(
                    'Dose ${record.doseNumber}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.secondaryText,
                    ),
                  ),

                  SizedBox(height: 3.h),

                  Text(
                    DateFormat('MMM dd, yyyy').format(record.date),
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: const Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.chevron_right,
              color: Color(0xFFCBD5E1),
            ),
          ],
        ),
      ),
    );
  }
}