import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildAuthToggleTab({
  required bool isLogin,
  required ValueChanged<bool> onToggle,
}) {
  return Container(
    height: 48.h,
    padding: EdgeInsets.all(4.w),
    decoration: BoxDecoration(
      color: const Color(0xFFF1F5F9),
      borderRadius: BorderRadius.circular(14.r),
    ),
    child: Row(
      children: [
        _buildTabItem(
          label: 'Login',
          isSelected: isLogin,
          onTap: () => onToggle(true),
        ),
        _buildTabItem(
          label: 'Register',
          isSelected: !isLogin,
          onTap: () => onToggle(false),
        ),
      ],
    ),
  );
}

Widget _buildTabItem({
  required String label,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  return Expanded(
    child: GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
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
            color: isSelected ? const Color(0xFF1E293B) : const Color(0xFF94A3B8),
          ),
        ),
      ),
    ),
  );
}