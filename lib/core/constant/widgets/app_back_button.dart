import 'package:pet_care/core/constant/theme/context_x.dart';
import 'package:flutter/material.dart';

class AppBackButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const AppBackButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ?? () => Navigator.of(context).pop(),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: context.colors.outlineVariant),
        ),
        child: Icon(
          Icons.chevron_left,
          color: context.colors.onSurfaceVariant,
          size: 20,
        ),
      ),
    );
  }
}
