
  import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';

Widget buildSeparator() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        children: [
          const Expanded(
            child: Divider(
              color: AppColors.border,
              thickness: 1,
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Text(
              'Or continue with',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 12.sp,
                height: 15 / 12,
                color: AppColors.secondaryText,
              ),
            ),
          ),

          const Expanded(
            child: Divider(
              color: AppColors.border,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }