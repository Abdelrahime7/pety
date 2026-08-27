import 'package:flutter/material.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';

class AppSaveButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;
  final String text;

  const AppSaveButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
    this.text = 'Save',
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary),
            )
          : Text(
              text,
              style: TextStyle(
                color: onPressed != null ? AppColors.primary : AppColors.primary.withOpacity(0.5),
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
    );
  }
}
