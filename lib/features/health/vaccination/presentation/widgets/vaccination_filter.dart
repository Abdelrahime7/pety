import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';

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
            backgroundColor: AppColors.surface,
            selectedColor: AppColors.primary,
            side: BorderSide(color: active ? AppColors.primary : AppColors.border),
            labelStyle: TextStyle(
              color: active ? Colors.white : AppColors.secondaryText,
              fontWeight: active ? FontWeight.w700 : FontWeight.w500,
              fontSize: 12.sp,
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
          );
        },
      ),
    );
  }
}