import 'package:flutter/material.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/core/constant/theme/app_style.dart';

class FieldLabel extends StatelessWidget {
  final String label;
  final EdgeInsetsGeometry? padding;

  const FieldLabel({
    super.key,
    required this.label,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(bottom: 8),
      child: Text(
        label.toUpperCase(),
        style: AppStyle.regular13.copyWith(
          color: AppColors.secondaryText,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}
