import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/features/health/domain/enums/health_record_type.dart';

class OwnerHealthRecordFilterChips extends StatelessWidget {
  const OwnerHealthRecordFilterChips({super.key, required this.selected, required this.onSelected});

  final String selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final filters = ['All', ...HealthRecordType.values.map((type) => type.name)];
    return SizedBox(
      height: 38.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, _) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final active = selected.toLowerCase() == filter.toLowerCase();
          return ChoiceChip(
            label: Text(filter[0].toUpperCase() + filter.substring(1)),
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