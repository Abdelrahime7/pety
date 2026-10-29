import 'package:pet_care/core/constant/theme/context_x.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeatureItem extends StatelessWidget {
  final String title;
  final String subtitle;

  const FeatureItem({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(4.r),
          decoration: BoxDecoration(
            color: context.colors.primary.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.check_rounded,
            size: 14.sp,
            color: context.colors.primary,
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
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: context.colors.onSurface,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: context.colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
