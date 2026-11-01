import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/core/constant/theme/context_x.dart';
import 'package:pet_care/core/constant/widgets/custom_text_field.dart';
import 'package:pet_care/features/authentication/presentation/validators/password_validator.dart';

Widget buildPasswordField(
  BuildContext context,
  void Function()? resetPassword,
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
        style: context.style.tileTitle.copyWith(
          fontSize: 11.sp,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
          color: context.colors.onSurfaceVariant,
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
          color: context.colors.onSurfaceVariant,
        ),
        suffixIcon: Icon(
          obscurePassword
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
          size: 18.sp,
          color: context.colors.onSurfaceVariant,
        ),
        onSuffixIconPressed: onSuffixIconPressed,
        validator: validatePassword,
      ),
      if (showForgotPassword) ...[
        SizedBox(height: 10.h),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: resetPassword,

            child: Text(
              'Forgot Password?',
              style: context.style.buttonText.copyWith(fontSize: 13.sp),
            ),
          ),
        ),
      ],
    ],
  );
}
