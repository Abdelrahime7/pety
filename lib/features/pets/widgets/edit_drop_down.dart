import 'package:pet_care/core/constant/theme/context_x.dart';

import 'package:flutter/material.dart';

Widget buildDropdown(
  BuildContext context, {
  required String label,
  required String value,
  required List<String> items,
  required ValueChanged<String?> onChanged,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: context.style.regular13.copyWith(
          color: context.colors.onSurface,
          fontWeight: FontWeight.w500,
        ),
      ),

      const SizedBox(height: 7),

      DropdownButtonFormField<String>(
        initialValue: value,
        onChanged: onChanged,
        style: context.style.regular14.copyWith(
          color: context.colors.onSurface,
        ),
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: context.colors.onSurfaceVariant,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: context.colors.surface,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: context.colors.outlineVariant),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: context.colors.outlineVariant),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: context.colors.primary, width: 1.5),
          ),
        ),
        items: items.map((item) {
          return DropdownMenuItem<String>(value: item, child: Text(item));
        }).toList(),
      ),
    ],
  );
}
