import 'package:flutter/material.dart';
import 'package:pet_care/core/constant/theme/context_x.dart';

import 'package:pet_care/core/constant/l10n/l10x.dart';
class LogoutActionCard extends StatelessWidget {
  final VoidCallback onTap;

  const LogoutActionCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final Color inkSoft = context.colors.onSurfaceVariant;
    final Color danger = context.colors.error;
    final Color dangerBackground = context.colors.error.withValues(alpha: 0.12);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: context.colors.surfaceContainer,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: context.colors.outlineVariant),
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
                    color: dangerBackground,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(Icons.logout_rounded, color: danger, size: 18),
                ),
                const SizedBox(width: 16),
                Text(
                  context.l10n.logOut,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: context.colors.onSurface,
                  ),
                ),
              ],
            ),
            Icon(Icons.chevron_right, color: inkSoft, size: 16),
          ],
        ),
      ),
    );
  }
}