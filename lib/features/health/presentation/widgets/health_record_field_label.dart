import 'package:pet_care/core/constant/theme/context_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            color: context.colors.onSurface,
          ),
        ),
        if (required)
          Text(
            ' *',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: context.colors.error,
            ),
          ),
      ],
    );
  }
}
