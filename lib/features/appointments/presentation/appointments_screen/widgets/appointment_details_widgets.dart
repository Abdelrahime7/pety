import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/features/pets/domain/entity/pet.dart';
import 'package:pet_care/features/appointments/domain/entity/appointment.dart';

class AppointmentDetailsTopBar extends StatelessWidget {
  final VoidCallback onEdit;

  const AppointmentDetailsTopBar({super.key, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: context.pop,
          child: Container(
            width: 42.w,
            height: 42.w,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: const Icon(Icons.arrow_back_rounded, color: Color(0xFF475569), size: 20),
          ),
        ),
        Text(
          'Appointment',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
        ),
        GestureDetector(
          onTap: onEdit,
          child: Container(
            width: 42.w,
            height: 42.w,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: const Icon(Icons.edit_outlined, color: AppColors.primary, size: 20),
          ),
        ),
      ],
    );
  }
}

class AppointmentPetCard extends StatelessWidget {
  final Pet? pet;
  final bool isPast;

  const AppointmentPetCard({super.key, required this.pet, required this.isPast});

  @override
  Widget build(BuildContext context) {
    final petName = pet?.name.isNotEmpty == true ? pet!.name : 'Pet';
    final petDetails = pet != null ? '${pet!.breed} • ${_formatAge(pet!.birthDate)}' : 'Pet details unavailable';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 14.h,
              bottom: 14.h,
              child: Container(
                width: 4.w,
                decoration: BoxDecoration(
                  color: isPast ? const Color(0xFFCBD5E1) : AppColors.primary,
                  borderRadius: BorderRadius.horizontal(right: Radius.circular(4.r)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
              child: Row(
                children: [
                  _AppointmentPetImage(url: pet?.photoUrl ?? '', size: 60.w),
                  SizedBox(width: 14.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                          decoration: BoxDecoration(
                            color: isPast ? const Color(0xFFF1F5F9) : const Color(0xFFE6FFFA),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            isPast ? 'Completed' : 'Upcoming',
                            style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w700, color: isPast ? AppColors.textSecondary : const Color(0xFF0D9488)),
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(petName, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                        SizedBox(height: 2.h),
                        Text(petDetails, style: TextStyle(fontSize: 12.sp, color: const Color(0xFF94A3B8), fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatAge(DateTime birthDate) {
    final now = DateTime.now();
    var years = now.year - birthDate.year;
    var months = now.month - birthDate.month;
    if (now.day < birthDate.day) months--;
    if (months < 0) {
      years--;
      months += 12;
    }
    if (years > 0) return '$years ${years == 1 ? 'yr' : 'yrs'} old';
    if (months > 0) return '$months ${months == 1 ? 'mo' : 'mos'} old';
    return 'Puppy / Kitten';
  }
}

class AppointmentInfoCard extends StatelessWidget {
  final Appointment appointment;

  const AppointmentInfoCard({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('EEEE, MMMM d, yyyy').format(appointment.date);
    final time = DateFormat('h:mm a').format(appointment.date);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22.r),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: Column(
        children: [
          AppointmentDetailRow(icon: Icons.calendar_today_outlined, label: 'DATE & TIME', value: '$date • $time'),
          const _DetailDivider(),
          AppointmentDetailRow(icon: Icons.person_outline_rounded, label: 'VETERINARIAN', value: appointment.veterinarian.isNotEmpty ? appointment.veterinarian : 'Not specified'),
          const _DetailDivider(),
          AppointmentDetailRow(icon: Icons.sticky_note_2_outlined, label: 'NOTES', value: appointment.notes.isNotEmpty ? appointment.notes : 'No notes added.', isNotes: true),
        ],
      ),
    );
  }
}

class AppointmentDetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isNotes;

  const AppointmentDetailRow({super.key, required this.icon, required this.label, required this.value, this.isNotes = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
      child: Row(
        crossAxisAlignment: isNotes ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Container(width: 40.w, height: 40.w, decoration: BoxDecoration(color: const Color(0xFFE6FFFA), borderRadius: BorderRadius.circular(12.r)), child: Icon(icon, size: 20, color: AppColors.primary)),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w700, letterSpacing: 0.5, color: const Color(0xFF94A3B8))),
                SizedBox(height: 4.h),
                Text(value, style: isNotes ? TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w400, height: 1.45, color: const Color(0xFF64748B)) : TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AppointmentActionButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final Color iconColor;
  final Color textColor;
  final String text;
  final Color backgroundColor;
  final BoxBorder? border;
  final bool hasShadow;

  const AppointmentActionButton({super.key, required this.onTap, required this.icon, required this.iconColor, required this.textColor, required this.text, required this.backgroundColor, this.border, this.hasShadow = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        height: 52.h,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16.r),
          border: border,
          boxShadow: hasShadow ? [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 6, offset: const Offset(0, 2))] : null,
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, size: 18, color: iconColor), SizedBox(width: 8.w), Text(text, style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700, color: textColor))]),
      ),
    );
  }
}

class _DetailDivider extends StatelessWidget {
  const _DetailDivider();

  @override
  Widget build(BuildContext context) => const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9), indent: 16, endIndent: 16);
}

class _AppointmentPetImage extends StatelessWidget {
  final String url;
  final double size;

  const _AppointmentPetImage({required this.url, required this.size});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        width: size,
        height: size,
        color: const Color(0xFFF1F5F9),
        child: url.isEmpty ? const Icon(Icons.pets, color: AppColors.icon, size: 24) : Image.network(url, fit: BoxFit.cover, errorBuilder: (_, _, _) => const Icon(Icons.pets, color: AppColors.icon, size: 24)),
      ),
    );
  }
}
