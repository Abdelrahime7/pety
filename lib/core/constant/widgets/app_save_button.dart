import 'package:flutter/material.dart';
import 'package:pet_care/core/constant/l10n/l10x.dart';
import 'package:pet_care/core/constant/theme/context_x.dart';

class AppSaveButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;
  /// Optional custom label. Defaults to the translated "Save".
  final String? text;

  const AppSaveButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: context.colors.primary,
              ),
            )
          : Text(
              text ?? context.l10n.save,
              style: TextStyle(
                color: onPressed != null
                    ? context.colors.primary
                    : context.colors.primary.withValues(alpha: 0.5),
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
    );
  }
}