import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/core/constant/theme/app_style.dart';
import 'package:pet_care/features/appointments/domain/entity/appointment.dart';

class UpcomingAppointmentCard extends StatelessWidget {
  final Appointment? appointment;

  const UpcomingAppointmentCard({
    super.key,
    required this.appointment,
  });

  @override
  Widget build(BuildContext context) {
    // Hide the card when there is no upcoming appointment.
    if (appointment == null) {
      return const SizedBox.shrink();
    }

    // Safe to use after the null check.
    final date = appointment!.date;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 58.w,
            height: 62.h,
            decoration: BoxDecoration(
              color: const Color(0xFFE0F7F3),
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _monthName(date.month),
                  style: AppStyle.sectionHeader.copyWith(
                    fontSize: 10.sp,
                    color: AppColors.tealDark,
                    letterSpacing: 0.8,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  '${date.day}',
                  style: AppStyle.title.copyWith(
                    fontSize: 22.sp,
                    color: AppColors.tealDark,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appointment!.type.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyle.tileTitle.copyWith(
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  _formatTime(date),
                  style: AppStyle.regular12.copyWith(
                    color: AppColors.tealDark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right_rounded,
            color: AppColors.icon,
            size: 25.sp,
          ),
        ],
      ),
    );
  }

  String _monthName(int month) {
    const months = [
      'JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN',
      'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC',
    ];

    return months[month - 1];
  }

  String _formatTime(DateTime date) {
    final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = date.hour >= 12 ? 'PM' : 'AM';

    return '$hour:$minute $period';
  }
}