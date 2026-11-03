import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pet_care/core/constant/l10n/display_labels.dart';
import 'package:pet_care/core/constant/l10n/to_english_digit.dart';
import 'package:pet_care/core/constant/theme/context_x.dart';
import 'package:pet_care/features/health/domain/entity/health_record.dart';
import 'package:pet_care/features/health/domain/enums/health_record_type.dart';

import 'package:pet_care/core/constant/l10n/l10x.dart';
class HealthRecordCard extends StatelessWidget {
  final HealthRecord record;
  final VoidCallback? onTap;

  const HealthRecordCard({super.key, required this.record, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(14.w),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 42.w,
              height: 42.w,
              decoration: BoxDecoration(
                color: record.recordType.backgroundColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                record.recordType.icon,
                color: record.recordType.color,
                size: 20.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          record.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14.5.sp,
                            fontWeight: FontWeight.w700,
                            color: context.colors.onSurface,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                       toEnglishDigits( DateFormat('MMM dd, yyyy', context.l10n.localeName).format(record.date)),
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: context.colors.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 3.h,
                    ),
                    decoration: BoxDecoration(
                      color: record.recordType.backgroundColor,
                      borderRadius: BorderRadius.circular(999.r),
                    ),
                    child: Text(
                     healthRecordTypeLabel(context.l10n, record.recordType),
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: record.recordType.color,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  if (record.notes.isNotEmpty) ...[
                    SizedBox(height: 6.h),
                    Text(
                      record.notes,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11.5.sp,
                        color: context.colors.onSurfaceVariant,
                        height: 1.35,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}