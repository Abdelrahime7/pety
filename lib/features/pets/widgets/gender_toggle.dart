import 'package:pet_care/core/constant/theme/context_x.dart';
import 'package:flutter/material.dart';

import 'package:pet_care/core/constant/l10n/l10x.dart';
class GenderToggle extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const GenderToggle({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _buildOption(context,label: context.l10n.male, index: 0),
          _buildOption(context,label: context.l10n.female, index: 1),
        ],
      ),
    );
  }

  Widget _buildOption( BuildContext context,{required String label, required int index}) {
    final isSelected = selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => onSelected(index),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected
                ? context.colors.surfaceContainer
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [],
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isSelected
                  ? context.colors.primary
                  : context.colors.onSurfaceVariant,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}