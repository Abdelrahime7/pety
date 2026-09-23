import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/features/appointments/domain/enums/appointment_types.dart';
import 'package:pet_care/features/appointments/presentation/appointments_screen/widgets/appointment_type_icon.dart';
import 'package:pet_care/features/appointments/presentation/appointments_screen/widgets/appointment_type_label.dart';

Widget buildAppointmentTypeSelector({required AppointmentType selectedType,
      required ValueChanged<AppointmentType?> onChanged})
 {
  return DropdownButtonFormField<AppointmentType>(
    initialValue: selectedType,

    icon: const Icon(
      Icons.keyboard_arrow_down_rounded,
      color: AppColors.textSecondary,
      size: 24,
    ),

    dropdownColor: AppColors.surface,

    borderRadius: BorderRadius.circular(16.r),

    elevation: 8,

    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white,

      contentPadding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 15.h,
      ),

      prefixIcon: Container(
        margin: EdgeInsets.only(
          left: 8.w,
          right: 8.w,
          top: 8.h,
          bottom: 8.h,
        ),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.10),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Icon(
          appointmentTypeIcon(selectedType),
          color: AppColors.primary,
          size: 20.sp,
        ),
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide.none,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(
          color: AppColors.border.withOpacity(0.5),
          width: 1,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: const BorderSide(
          color: AppColors.primary,
          width: 1.5,
        ),
      ),
    ),

    selectedItemBuilder: (context) {
      return AppointmentType.values.map((type) {
        return Align(
          alignment: Alignment.centerLeft,
          child: Text(
            appointmentTypeLabel(type),
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        );
      }).toList();
    },

    items: AppointmentType.values.map((type) {
      final isSelected = type == selectedType;

      return DropdownMenuItem<AppointmentType>(
        value: type,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 4.w,
            vertical: 8.h,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primary.withOpacity(0.08)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              Container(
                width: 38.w,
                height: 38.w,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary.withOpacity(0.12)
                      : Colors.grey.withOpacity(0.07),
                  borderRadius: BorderRadius.circular(11.r),
                ),
                child: Icon(
                  appointmentTypeIcon(type),
                  size: 19.sp,
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.textSecondary,
                ),
              ),

              SizedBox(width: 12.w),

              Expanded(
                child: Text(
                  appointmentTypeLabel(type),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: isSelected
                        ? FontWeight.w700
                        : FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),

              if (isSelected)
                Icon(
                  Icons.check_rounded,
                  color: AppColors.primary,
                  size: 20.sp,
                ),
            ],
          ),
        ),
      );
    }).toList(),

    onChanged: (value) {
  if (value != null) {
    onChanged(value);
  }
    }
  );
 }
 


