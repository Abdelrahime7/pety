import 'package:pet_care/core/constant/theme/context_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

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
          color: context.colors.surfaceContainer,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: context.colors.outlineVariant),
        ),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: context.colors.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.vaccines_outlined,
                color: context.colors.primary,
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
                      color: context.colors.onSurface,
                    ),
                  ),

                  SizedBox(height: 4.h),

                  Text(
                    'Dose ${record.doseNumber}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: context.colors.onSurfaceVariant,
                    ),
                  ),

                  SizedBox(height: 3.h),

                  Text(
                    DateFormat('MMM dd, yyyy').format(record.date),
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: context.colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),

            Icon(Icons.chevron_right, color: context.colors.outlineVariant),
          ],
        ),
      ),
    );
  }
}
