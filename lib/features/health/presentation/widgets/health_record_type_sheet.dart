import 'package:pet_care/core/constant/theme/context_x.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pet_care/features/health/domain/enums/health_record_type.dart';

import 'package:pet_care/core/constant/l10n/l10x.dart';
class HealthRecordTypeSheet extends StatelessWidget {
  final HealthRecordType selectedType;

  const HealthRecordTypeSheet({super.key, required this.selectedType});

  @override
  Widget build(BuildContext context) {
    final types = HealthRecordType.values;

    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainer,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: context.colors.outlineVariant,
                    borderRadius: BorderRadius.circular(999.r),
                  ),
                ),
              ),
              SizedBox(height: 18.h),
              Text(
                context.l10n.recordType,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800,
                  color: context.colors.onSurface,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                context.l10n.whatKindOfRecord,
                style: TextStyle(
                  fontSize: 12.5.sp,
                  color: context.colors.onSurfaceVariant,
                ),
              ),
              SizedBox(height: 16.h),
              ...types.map((type) {
                final isSelected = type == selectedType;

                return Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(type),
                      borderRadius: BorderRadius.circular(14.r),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        padding: EdgeInsets.all(11.w),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? type.backgroundColor
                              : context.colors.surface,
                          borderRadius: BorderRadius.circular(14.r),
                          border: Border.all(
                            color: isSelected
                                ? type.color.withValues(alpha: 0.3)
                                : context.colors.outlineVariant,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 42.w,
                              height: 42.w,
                              decoration: BoxDecoration(
                                color: type.backgroundColor,
                                borderRadius: BorderRadius.circular(11.r),
                              ),
                              child: Icon(
                                type.icon,
                                color: type.color,
                                size: 21.sp,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Text(
                                type.displayName,
                                style: TextStyle(
                                  fontSize: 13.5.sp,
                                  fontWeight: isSelected
                                      ? FontWeight.w700
                                      : FontWeight.w600,
                                  color: context.colors.onSurface,
                                ),
                              ),
                            ),
                            if (isSelected)
                              Icon(
                                Icons.check_circle_rounded,
                                color: type.color,
                                size: 21.sp,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}