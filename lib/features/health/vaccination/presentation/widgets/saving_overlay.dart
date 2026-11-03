import 'package:flutter/material.dart';
import 'package:pet_care/core/constant/theme/context_x.dart';

import 'package:pet_care/core/constant/l10n/l10x.dart';
class SavingOverlay extends StatelessWidget {
  /// Optional custom message. Defaults to the translated "Saving…".
  final String? message;

  const SavingOverlay({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Positioned.fill(
      child: Container(
        color: Colors.black.withValues(alpha: 0.3),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: colors.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(color: colors.primary),
                const SizedBox(height: 16),
                Text(
                  message ?? context.l10n.saving,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: colors.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}