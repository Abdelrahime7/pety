import 'package:pet_care/core/constant/theme/context_x.dart';
import 'package:flutter/material.dart';

class FieldLabel extends StatelessWidget {
  final String label;

  const FieldLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: context.colors.onSurfaceVariant,
        letterSpacing: 0.5,
      ),
    );
  }
}
