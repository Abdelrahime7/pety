import 'package:flutter/material.dart';
import 'package:pet_care/core/constant/theme/context_x.dart';

class SeriesOptionCard extends StatelessWidget {
  final String title;
  final bool selected;
  final IconData collapsedIcon;
  final VoidCallback onTap;
  final Widget child;

  const SeriesOptionCard({
    super.key,
    required this.title,
    required this.selected,
    required this.collapsedIcon,
    required this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final iconColor = selected ? colors.primary : colors.onSurfaceVariant;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: double.infinity,
      decoration: BoxDecoration(
        color: selected ? colors.surfaceContainer : colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: selected
              ? colors.primary.withValues(alpha: 0.35)
              : colors.outlineVariant,
        ),
        boxShadow: selected
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : [],
      ),
      child: Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Icon(
                    selected
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                    size: 21,
                    color: iconColor,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: colors.onSurface,
                      ),
                    ),
                  ),
                  Icon(
                    selected ? Icons.keyboard_arrow_up_rounded : collapsedIcon,
                    size: 21,
                    color: iconColor,
                  ),
                ],
              ),
            ),
          ),
          if (selected) ...[
            Divider(height: 1, color: colors.outlineVariant),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
              child: child,
            ),
          ],
        ],
      ),
    );
  }
}
