import 'package:pet_care/core/constant/theme/context_x.dart';
import 'package:flutter/material.dart';

import 'package:pet_care/core/constant/l10n/l10x.dart';
/// Small uppercase section label, e.g. "UPCOMING" or "PAST".
class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: context.tracking(0.5),
          color: context.colors.outlineVariant,
        ),
      ),
    );
  }
}