import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/features/health/domain/entity/health_record.dart';

class HealthRecordCard extends StatelessWidget {
  final HealthRecord record;

  const HealthRecordCard({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    final typeLabel = _label(record.type.name);
    final color = _color(record.type);

    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38.w,
            height: 38.w,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(_icon(record.type), color: color, size: 19.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        record.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.text,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      DateFormat('MMM d, yyyy').format(record.date),
                      style: TextStyle(fontSize: 10.sp, color: AppColors.secondaryText),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(999.r),
                  ),
                  child: Text(
                    typeLabel,
                    style: TextStyle(fontSize: 10.sp, color: color, fontWeight: FontWeight.w700),
                  ),
                ),
                if (record.notes.isNotEmpty) ...[
                  SizedBox(height: 7.h),
                  Text(
                    record.notes,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 11.sp, color: AppColors.secondaryText, height: 1.35),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _label(String value) => value[0].toUpperCase() + value.substring(1);

  IconData _icon(dynamic type) => switch (type.name) {
        'vaccination' => Icons.vaccines_outlined,
        'checkup' => Icons.health_and_safety_outlined,
        'medication' => Icons.medication_outlined,
        'allergy' => Icons.warning_amber_outlined,
        'surgery' => Icons.content_cut_outlined,
        _ => Icons.description_outlined,
      };

  Color _color(dynamic type) => switch (type.name) {
        'vaccination' => const Color(0xFF0D9488),
        'checkup' => const Color(0xFF0284C7),
        'medication' => const Color(0xFFF97316),
        'allergy' => const Color(0xFFEF4444),
        'surgery' => const Color(0xFF8B5CF6),
        _ => AppColors.textSecondary,
      };
}
