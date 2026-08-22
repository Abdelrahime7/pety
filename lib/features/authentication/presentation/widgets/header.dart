import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/core/constant/theme/app_style.dart';
import 'package:pet_care/features/authentication/presentation/widgets/app_logo.dart';

Widget buildHeader() {
  return Padding(
    padding: EdgeInsets.only(top: 24.h),
    child: Column(
      children: [
        SizedBox(
          width: 160.w,
          height: 130.h,
          child:AppLogo(
          size: 64.w,     // Sets exact square dimensions
          iconSize: 32.w, // Proportional icon size
        ),
        ),

       SizedBox(height: 8.h),

        Text('PetCare', style: AppStyle.title),

        SizedBox(height: 4.h),

        Text('Caring for your best friends', style: AppStyle.regular14),
      ],
    ),
  );
}
