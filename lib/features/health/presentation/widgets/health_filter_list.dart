import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/core/constant/theme/context_x.dart';

import 'package:pet_care/core/constant/l10n/l10x.dart';
import 'package:pet_care/core/constant/l10n/display_labels.dart';
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
              filter.toLowerCase() == selectedFilter.toLowerCase();

          return Padding(
            padding: EdgeInsetsDirectional.only(end: 8.w),
            child: GestureDetector(
              onTap: () => onFilterSelected(filter),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: isSelected ? context.colors.primary : Colors.white,
                  borderRadius: BorderRadius.circular(999.r),
                  border: Border.all(
                    color: isSelected
                        ? context.colors.primary
                        : context.colors.outlineVariant,
                  ),
                ),
                child: Text(
                  filterLabel(context.l10n, filter),
                  style: TextStyle(
                    fontSize: 12.5.sp,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected
                        ? Colors.white
                        : context.colors.onSurfaceVariant,
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