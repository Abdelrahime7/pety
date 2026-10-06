import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pet_care/core/constant/theme/app_colors.dart';

class HealthRecordFieldLabel extends StatelessWidget {
  final String label;
  final bool required;

  const HealthRecordFieldLabel({
    super.key,
    required this.label,
    required this.required,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.text,
          ),
        ),
        if (required)
          Text(
            ' *',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.error,
            ),
          ),
      ],
    );
  }
}
