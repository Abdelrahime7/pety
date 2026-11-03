import 'package:flutter/material.dart';
import 'package:pet_care/core/constant/l10n/l10x.dart';
import 'package:pet_care/core/constant/theme/context_x.dart';

class FieldLabel extends StatelessWidget {
  final String label;
  final EdgeInsetsGeometry? padding;

  const FieldLabel({super.key, required this.label, this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(bottom: 8),
      child: Text(
        label.toUpperCase(),
        style: context.style.regular13.copyWith(
          color: context.colors.onSurfaceVariant,
          fontWeight: FontWeight.w700,
          letterSpacing: context.tracking(0.8),
        ),
      ),
    );
  }
}