import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/core/constant/theme/app_style.dart';

Widget buildRegisterFooter() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text("Don't have an account?", style: AppStyle.regular14),

      SizedBox(width: 4.w),

      GestureDetector(
        onTap: () {},
        child: Text('Sign Up', style: AppStyle.buttonText),
      ),
    ],
  );
}
