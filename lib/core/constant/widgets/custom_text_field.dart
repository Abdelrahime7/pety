import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/core/constant/theme/context_x.dart';

class CustomeTextField extends StatelessWidget {
  final bool? enabled;
  final String? hintText;
  final Widget? suffixIcon;
  final bool isPassword;
  final double? width;
  final double? height;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final VoidCallback? onSuffixIconPressed;
  final int? maxLines;
  final bool readOnly;
  final void Function()? onTap;
  final String? suffixText;
  final String? label;
  final Color? fillColor;
  final TextInputAction? textInputAction;

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
    this.prefixIcon,
    this.onSuffixIconPressed,
    this.maxLines = 1,
    this.readOnly = false,
    this.onTap,
    this.suffixText,
    this.label,
    this.enabled,
    this.fillColor,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null && label!.isNotEmpty) ...[
          Text(
            label!,
            style: context.style.regular13.copyWith(
              color: context.colors.onSurface,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 7),
        ],
        TextFormField(
          enabled: enabled,
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          obscureText: isPassword,
          cursorColor: context.colors.primary,
          autofocus: false,
          maxLines: maxLines,
          readOnly: readOnly,
          onTap: onTap,
          style: context.style.regular14.copyWith(
            color: context.colors.onSurface,
          ),
          textInputAction: textInputAction,
          decoration: InputDecoration(
            suffixText: suffixText,
            suffixStyle: context.style.regular13.copyWith(
              color: context.colors.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
            filled: true,
            fillColor: fillColor ?? context.colors.surfaceContainerHighest,
            hintText: hintText ?? '',
            hintStyle: context.style.regular14,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon != null
                ? IconButton(
                    onPressed: onSuffixIconPressed,
                    icon: suffixIcon!,
                  )
                : null,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: maxLines != null && maxLines! > 1 ? 12.h : 0,
            ),
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
            border: _inputBorder(context),
            enabledBorder: _inputBorder(context),
            focusedBorder: _focusedBorder(context),
            errorBorder: _errorBorder(context),
            focusedErrorBorder: _errorBorder(context),
            errorStyle: context.style.regular12.copyWith(
              color: context.colors.error,
            ),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _inputBorder(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(
        color: context.colors.outlineVariant,
        width: 1.w,
      ),
    );
  }

  OutlineInputBorder _focusedBorder(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(
        color: context.colors.primary,
        width: 1.w,
      ),
    );
  }

  OutlineInputBorder _errorBorder(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(
        color: context.colors.error,
        width: 1.w,
      ),
    );
  }
}