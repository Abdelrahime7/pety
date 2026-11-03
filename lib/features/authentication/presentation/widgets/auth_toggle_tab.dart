import 'package:pet_care/core/constant/l10n/l10x.dart';
import 'package:pet_care/core/constant/theme/context_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildAuthToggleTab(BuildContext context,{
  required bool isLogin,
  required ValueChanged<bool> onToggle,
}) {
  return Container(
    height: 48.h,
    padding: EdgeInsets.all(4.w),
    decoration: BoxDecoration(
      color: context.colors.surfaceContainerHigh,
      borderRadius: BorderRadius.circular(14.r),
    ),
    child: Row(
      children: [
        _buildTabItem(context,
          label: context.l10n.login,
          isSelected: isLogin,
          onTap: () => onToggle(true),
        ),
        _buildTabItem(context,
          label: context.l10n.register,
          isSelected: !isLogin,
          onTap: () => onToggle(false),
        ),
      ],
    ),
  );
}

Widget _buildTabItem(BuildContext context,{
  required String label,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  return Expanded(
    child: GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration:  Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected
              ? context.colors.surfaceContainer
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected
                ? context.colors.onSurface
                : context.colors.onSurfaceVariant,
          ),
        ),
      ),
    ),
  );
}