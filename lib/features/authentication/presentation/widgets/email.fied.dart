import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/core/constant/theme/app_style.dart';
import 'package:pet_care/core/constant/widgets/custom_text_field.dart';
import 'package:pet_care/features/authentication/presentation/validators/email_validator.dart';

Widget buildEmailField(TextEditingController emailController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'EMAIL ADDRESS',
        style: AppStyle.tileTitle.copyWith(
          fontSize: 11.sp,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
          color: const Color(0xFF8A94A6),
        ),
      ),
      SizedBox(height: 6.82.h),
      CustomeTextField(
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        hintText: 'name@example.com',
        prefixIcon: Icon(
          Icons.mail_outline_rounded,
          size: 18.sp,
          color: AppColors.icon,
        ),
        validator: validateEmail,
      ),
    ],
  );
}