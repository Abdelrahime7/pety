import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/core/constant/theme/context_x.dart';

Widget buildSeparator(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 24.w),
    child: Row(
      children: [
        Expanded(
          child: Divider(color: context.colors.outlineVariant, thickness: 1),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Text(
            'Or continue with',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 12.sp,
              height: 15 / 12,
              color: context.colors.onSurfaceVariant,
            ),
          ),
        ),

        Expanded(
          child: Divider(color: context.colors.outlineVariant, thickness: 1),
        ),
      ],
    ),
  );
}
