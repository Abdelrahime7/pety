import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/core/constant/theme/app_style.dart';
import 'package:pet_care/core/constant/widgets/custom_text_field.dart';
import 'package:pet_care/features/authentication/presentation/validators/password_validator.dart';

Widget buildPasswordField(
  TextEditingController passwordController,
  void Function() onSuffixIconPressed,
  bool obscurePassword, {
  bool showForgotPassword = true,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'PASSWORD',
        style: AppStyle.tileTitle.copyWith(
          fontSize: 11.sp,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
          color: const Color(0xFF8A94A6),
        ),
      ),
      SizedBox(height: 6.82.h),
      CustomeTextField(
        controller: passwordController,
        isPassword: obscurePassword,
        hintText: '••••••••',
        prefixIcon: Icon(
          Icons.lock_rounded,
          size: 18.sp,
          color: AppColors.icon,
        ),
        suffixIcon: Icon(
          obscurePassword
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
          size: 18.sp,
          color: AppColors.secondaryText,
        ),
        onSuffixIconPressed: onSuffixIconPressed,
        validator: validatePassword,
      ),
      if (showForgotPassword) ...[
        SizedBox(height: 10.h),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: _handleForgotPassword,
            child: Text(
              'Forgot Password?',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2DD4BF),
              ),
            ),
          ),
        ),
      ],
    ],
  );
}

void _handleForgotPassword() {
  // Navigate to forgot password screen
}