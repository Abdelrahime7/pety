import 'package:flutter/material.dart';
import 'package:pet_care/core/constant/theme/context_x.dart';

import 'package:pet_care/core/constant/l10n/l10x.dart';
class SecurityActionCard extends StatelessWidget {
  final VoidCallback onTap;

  const SecurityActionCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: colors.surfaceContainer,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: colors.outlineVariant),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 4,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    // Tinted background works in both modes
                    color: colors.error.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(Icons.key, color: colors.error, size: 16),
                ),
                const SizedBox(width: 16),
                Text(
                  context.l10n.changePassword,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: colors.onSurface,
                  ),
                ),
              ],
            ),
            Icon(Icons.chevron_right, color: colors.onSurfaceVariant, size: 16),
          ],
        ),
      ),
    );
  }
}