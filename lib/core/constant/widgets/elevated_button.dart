import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/core/constant/theme/context_x.dart';

class ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;

  const ActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: context.colors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      child: Text(
        label,
        style: context.style.badgeCapsule.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
    );
  }
}
