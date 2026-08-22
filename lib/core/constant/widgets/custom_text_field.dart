import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/core/constant/theme/app_style.dart';

class CustomeTextField extends StatelessWidget {
  final String? hintText;
  final Widget? suffixIcon;
  final bool isPassword;
  final double? width;
  final double? height;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool readOnly;
  final VoidCallback? onTap;
  final int maxLines;
  final Widget? prefixIcon;
  final VoidCallback? onSuffixIconPressed;

  const CustomeTextField({
    super.key,
    this.hintText,
    this.suffixIcon,
    this.isPassword = false,
    this.width,
    this.height,
    required this.controller,
    this.validator,
    this.keyboardType,
    this.readOnly = false,
    this.onTap,
    this.maxLines = 1,
    this.prefixIcon,
    this.onSuffixIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      maxLines: maxLines,
      readOnly: readOnly,
      onTap: onTap,
      obscureText: isPassword,
      cursorColor: AppColors.primary,
      autofocus: false,

      style: AppStyle.regular14,

      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF7F8F9),

        hintText: hintText ?? '',
        hintStyle: AppStyle.regular14,

        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon != null
            ? IconButton(onPressed: onSuffixIconPressed, icon: suffixIcon!)
            : null,

        contentPadding: EdgeInsets.symmetric(horizontal: 6.w,vertical:16.h),

        prefixIconConstraints: BoxConstraints(
          minWidth: 48.w,
          maxWidth: 48.w,
          minHeight: 48.h,
          maxHeight: 48.h,
        ),

        suffixIconConstraints: BoxConstraints(
          minWidth: 48.w,
          maxWidth: 48.w,
          minHeight: 48.h,
          maxHeight: 48.h,
        ),

        border: _inputBorder(),
        enabledBorder: _inputBorder(),
        focusedBorder: _focusedBorder(),
        errorBorder: _errorBorder(),
        focusedErrorBorder: _errorBorder(),

        // Important
        errorStyle: AppStyle.regular12.copyWith(height: 1.2),
      ),
    );
  }

  OutlineInputBorder _inputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(color: AppColors.border, width: 1.w),
    );
  }

  OutlineInputBorder _focusedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(color: AppColors.primary, width: 1.w),
    );
  }

  OutlineInputBorder _errorBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(color: Colors.red, width: 1.w),
    );
  }
}
