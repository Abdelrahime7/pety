import 'package:pet_care/core/constant/theme/context_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppCloseButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double? size;
  final Color? backgroundColor;
  final Color? iconColor;

  const AppCloseButton({
    super.key,
    this.onPressed,
    this.size,
    this.backgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveSize = size ?? 39.r;
    final bgColor = backgroundColor ?? context.colors.onSecondary;
    final fgColor = iconColor ?? context.colors.onSurfaceVariant;

    return Material(
      color: bgColor,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed ?? () => Navigator.maybePop(context),
        child: SizedBox(
          width: effectiveSize,
          height: effectiveSize,
          child: Icon(
            Icons.close_rounded,
            size: effectiveSize * 0.5,
            color: fgColor,
          ),
        ),
      ),
    );
  }
}
