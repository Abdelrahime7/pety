import 'package:pet_care/core/constant/theme/context_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OwnerVaccinationFilterChips extends StatelessWidget {
  const OwnerVaccinationFilterChips({
    super.key,
    required this.selected,
    required this.petNames,
    required this.onSelected,
  });

  final String selected;
  final List<String> petNames;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final filters = ['All', ...petNames];
    return SizedBox(
      height: 38.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, _) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final active = selected == filter;
          return ChoiceChip(
            label: Text(filter),
            selected: active,
            onSelected: (_) => onSelected(filter),
            showCheckmark: false,
            backgroundColor: context.colors.surface,
            selectedColor: context.colors.primary,
            side: BorderSide(
              color: active
                  ? context.colors.primary
                  : context.colors.outlineVariant,
            ),
            labelStyle: TextStyle(
              color: active ? Colors.white : context.colors.onSurfaceVariant,
              fontWeight: active ? FontWeight.w700 : FontWeight.w500,
              fontSize: 12.sp,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
          );
        },
      ),
    );
  }
}
