import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/features/health/domain/entity/health_record.dart';
import 'package:pet_care/features/health/domain/enums/health_record_type.dart';

void showHealthRecordDetailsSheet(
  BuildContext context,
  HealthRecord record,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => HealthRecordDetailsSheet(
      record: record,
    ),
  );
}

class HealthRecordDetailsSheet extends StatelessWidget {
  final HealthRecord record;

  const HealthRecordDetailsSheet({
    super.key,
    required this.record,
  });

  @override
  Widget build(BuildContext context) {
    return _DetailsSheetContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Header(
            icon: record.recordType.icon,
            iconColor: record.recordType.color,
            title: record.title,
            subtitle: record.recordType.name,
          ),

          SizedBox(height: 20.h),

          _DetailLabel(
            label: 'Date',
            value: DateFormat(
              'MMM dd, yyyy',
            ).format(record.date),
          ),

          if (record.veterinarian.isNotEmpty) ...[
            SizedBox(height: 12.h),
            _DetailLabel(
              label: 'Veterinarian',
              value: record.veterinarian,
            ),
          ],

          if (record.notes.isNotEmpty) ...[
            SizedBox(height: 12.h),
            _DetailLabel(
              label: 'Notes',
              value: record.notes,
            ),
          ],

          SizedBox(height: 20.h),

          _CloseButton(
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;

  const _Header({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 48.w,
          height: 48.w,
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 24.sp,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.text,
                ),
              ),
              SizedBox(height: 3.h),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.secondaryText,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DetailsSheetContainer extends StatelessWidget {
  final Widget child;

  const _DetailsSheetContainer({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20.w,
        12.h,
        20.w,
        24.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24.r),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: child,
        ),
      ),
    );
  }
}

class _DetailLabel extends StatelessWidget {
  final String label;
  final String value;

  const _DetailLabel({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF94A3B8),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.text,
          ),
        ),
      ],
    );
  }
}

class _CloseButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _CloseButton({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: EdgeInsets.symmetric(
            vertical: 13.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          'Close',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}