import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';

Widget buildRegisterFooter({
  required bool isLogin,
  required VoidCallback onTap,
}) {
  return RichText(
    text: TextSpan(
      text: isLogin ? "Don't have an account? " : "Already have an account? ",
      style: TextStyle(
        fontSize: 13.sp,
        color: const Color(0xFF64748B),
      ),
      children: [
        TextSpan(
          text: isLogin ? 'Sign Up' : 'Sign In',
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
          recognizer: TapGestureRecognizer()..onTap = onTap,
        ),
      ],
    ),
  );
}