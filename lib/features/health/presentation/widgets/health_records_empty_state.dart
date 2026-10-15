import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/core/constant/theme/app_style.dart';

class OwnerHealthRecordsEmptyState extends StatelessWidget {
  const OwnerHealthRecordsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 54.h, horizontal: 20.w),
      child: Column(
        children: [
          Container(
            width: 64.w,
            height: 64.w,
            decoration: const BoxDecoration(color: Color(0xFFEAFBF8), shape: BoxShape.circle),
            child: const Icon(Icons.health_and_safety_outlined, size: 30, color: AppColors.tealDark),
          ),
          SizedBox(height: 14.h),
          Text('No health records yet', style: AppStyle.sectionHeader),
          SizedBox(height: 6.h),
          Text(
            'Health records for all your pets will appear here.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.sp, color: AppColors.secondaryText),
          ),
        ],
      ),
    );
  }
}