import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/core/constant/theme/app_style.dart';

Widget buildHeader() {
  return Padding(
    padding: EdgeInsets.only(top: 24.h),
    child: Column(
      children: [
        SizedBox(
          width: 160.w,
          height: 130.h,
          child: Image.asset(
            'assets/images/MascotIllustration.png',
            fit: BoxFit.contain,
          ),
        ),

        SizedBox(height: 12.h),

        Text('PetyPaw+', style: AppStyle.title),

        SizedBox(height: 4.h),

        Text('Caring for your best friends', style: AppStyle.regular14),
      ],
    ),
  );
}
