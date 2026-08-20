import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';

class AppPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? height;
  final double? width;
  final double borderRadius;
  final Color? backgroundColor;

  const AppPrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.height,
    this.width = double.infinity,
    this.borderRadius = 16.0,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    // Apply .h dynamically at build time
    final effectiveHeight = height ?? 56.h;
    final buttonColor = backgroundColor ?? AppColors.primary;
    final isDisabled = onPressed == null || isLoading;

    return Container(
      width: width,
      height: effectiveHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius.r),
        boxShadow: isDisabled
            ? null
            : [
                BoxShadow(
                  color: buttonColor.withValues(alpha: 0.35),
                  blurRadius: 16.r,
                  spreadRadius: 0,
                  offset: Offset(0, 8.h),
                ),
              ],
      ),
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          disabledBackgroundColor: buttonColor.withValues(alpha: 0.5),
          foregroundColor: Colors.white,
          disabledForegroundColor: Colors.white70,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24.w),
        ),
        child: isLoading
            ? SizedBox(
                width: 24.w,
                height: 24.h,
                child: const CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                text,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
              ),
      ),
    );
  }
}
