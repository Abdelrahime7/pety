import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pet_care/core/constant/theme/app_colors.dart';

class HealthFilterList extends StatelessWidget {
  final String selectedFilter;
  final ValueChanged<String> onFilterSelected;

  const HealthFilterList({
    super.key,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  static const filters = [
    'All',
    'Vaccination',
    'Checkup',
    'Medication',
    'Allergy',
    'Surgery',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: filters.map((filter) {
          final isSelected =
              filter.toLowerCase() ==
              selectedFilter.toLowerCase();

          return Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: GestureDetector(
              onTap: () => onFilterSelected(filter),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 8.h,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary
                      : Colors.white,
                  borderRadius: BorderRadius.circular(999.r),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary
                        : const Color(0xFFE2E8F0),
                  ),
                ),
                child: Text(
                  filter,
                  style: TextStyle(
                    fontSize: 12.5.sp,
                    fontWeight: isSelected
                        ? FontWeight.w700
                        : FontWeight.w500,
                    color: isSelected
                        ? Colors.white
                        : const Color(0xFF64748B),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}