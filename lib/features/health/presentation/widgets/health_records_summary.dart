import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/core/constant/theme/app_style.dart';

class OwnerHealthRecordsSummary extends StatelessWidget {
  const OwnerHealthRecordsSummary({super.key, required this.total, required this.petCount});

  final int total;
  final int petCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        gradient: AppColors.premiumCardGradient,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          const Icon(Icons.health_and_safety_outlined, color: Colors.white, size: 32),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Your pets’ health',
                    style: AppStyle.sectionHeader.copyWith(color: Colors.white)),
                SizedBox(height: 5.h),
                Text('$total records across $petCount pets',
                    style: TextStyle(color: Colors.white.withOpacity(.9), fontSize: 12.sp)),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.18),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text('$total',
                style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w800)),
          ),
        ],
      ),
    );
  }
}