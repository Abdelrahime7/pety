import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/core/constant/theme/context_x.dart';
import 'package:pet_care/features/appointments/domain/enums/appointment_types.dart';
import 'package:pet_care/features/appointments/presentation/appointments_screen/widgets/appointment_type_icon.dart';
import 'package:pet_care/features/appointments/presentation/appointments_screen/widgets/appointment_type_label.dart';

Widget buildAppointmentTypeSelector(
  BuildContext context, {
  required AppointmentType selectedType,
  required ValueChanged<AppointmentType?> onChanged,
}) {
  return DropdownButtonFormField<AppointmentType>(
    initialValue: selectedType,

    icon: Icon(
      Icons.keyboard_arrow_down_rounded,
      color: context.colors.onSurfaceVariant,
      size: 24,
    ),

    dropdownColor: context.colors.surface,

    borderRadius: BorderRadius.circular(16.r),

    elevation: 8,

    decoration: InputDecoration(
      filled: true,
      fillColor: context.colors.surfaceContainer,

      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),

      prefixIcon: Container(
        margin: EdgeInsets.only(left: 8.w, right: 8.w, top: 8.h, bottom: 8.h),
        decoration: BoxDecoration(
          color: context.colors.primary.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Icon(
          appointmentTypeIcon(selectedType),
          color: context.colors.primary,
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
          color: context.colors.outlineVariant.withValues(alpha: 0.5),
          width: 1,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: context.colors.primary, width: 1.5),
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
              color: context.colors.onSurface,
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
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: isSelected
                ? context.colors.primary.withValues(alpha: 0.08)
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
                      ? context.colors.primary.withValues(alpha: 0.12)
                      : context.colors.onSurfaceVariant.withValues(alpha: 0.07),
                  borderRadius: BorderRadius.circular(11.r),
                ),
                child: Icon(
                  appointmentTypeIcon(type),
                  size: 19.sp,
                  color: isSelected
                      ? context.colors.primary
                      : context.colors.onSurfaceVariant,
                ),
              ),

              SizedBox(width: 12.w),

              Expanded(
                child: Text(
                  appointmentTypeLabel(type),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: context.colors.onSurface,
                  ),
                ),
              ),

              if (isSelected)
                Icon(
                  Icons.check_rounded,
                  color: context.colors.primary,
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
    },
  );
}
