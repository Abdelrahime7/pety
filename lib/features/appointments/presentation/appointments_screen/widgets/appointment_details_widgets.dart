import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_care/core/constant/l10n/l10x.dart';
import 'package:pet_care/core/constant/l10n/to_english_digit.dart';
import 'package:pet_care/core/constant/theme/context_x.dart';
import 'package:pet_care/features/appointments/presentation/appointments_screen/widgets/appointment_type_icon.dart';
import 'package:pet_care/features/appointments/presentation/appointments_screen/widgets/appointment_type_label.dart';
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
              border: Border.all(color: context.colors.outlineVariant),
            ),
            child: Icon(
              Icons.arrow_back_rounded,
              color: context.colors.onSurfaceVariant,
              size: 20,
            ),
          ),
        ),
        Text(
        context.l10n.appointment,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: context.colors.onSurface,
          ),
        ),
        GestureDetector(
          onTap: onEdit,
          child: Container(
            width: 42.w,
            height: 42.w,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: context.colors.outlineVariant),
            ),
            child: Icon(
              Icons.edit_outlined,
              color: context.colors.primary,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}

class AppointmentPetCard extends StatelessWidget {
  final Pet? pet;
  final bool isPast;

  const AppointmentPetCard({
    super.key,
    required this.pet,
    required this.isPast,
  });

  @override
  Widget build(BuildContext context) {
    final petName = pet?.name.isNotEmpty == true ? pet!.name : context.l10n.pet;
    final petDetails = pet != null
       ? '${pet!.breed} • ${_formatAge(context, pet!.birthDate)}'
: context.l10n.petDetailsUnavailable;
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surfaceContainer,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
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
                  color: isPast
                      ? context.colors.outlineVariant
                      : context.colors.primary,
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(4.r),
                  ),
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
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 3.h,
                          ),
                          decoration: BoxDecoration(
                            color: isPast
                                ? context.colors.outlineVariant
                                : context.colors.primary.withValues(
                                    alpha: 0.12,
                                  ),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            isPast ?context.l10n.completed : context.l10n.upcoming,
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w700,
                              color: isPast
                                  ? context.colors.onSurfaceVariant
                                  : context.colors.primary,
                            ),
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          petName,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w800,
                            color: context.colors.onSurface,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          petDetails,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: context.colors.onSurfaceVariant,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
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
String _formatAge(BuildContext context, DateTime birthDate) {
  final now = DateTime.now();
  var years = now.year - birthDate.year;
  var months = now.month - birthDate.month;
  if (now.day < birthDate.day) months--;
  if (months < 0) {
    years--;
    months += 12;
  }
  if (years > 0) return context.l10n.ageYearsOld(years);
  if (months > 0) return context.l10n.ageMonthsOld(months);
  return context.l10n.puppyKitten;
}
}
class AppointmentInfoCard extends StatelessWidget {
  final Appointment appointment;

  const AppointmentInfoCard({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
   final date = toEnglishDigits(
  DateFormat('EEEE, MMMM d, yyyy', context.l10n.localeName)
      .format(appointment.date),
);

final time = toEnglishDigits(
  DateFormat('h:mm a', context.l10n.localeName)
      .format(appointment.date),
);
  
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surfaceContainer,
        borderRadius: BorderRadius.circular(22.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // TYPE
          AppointmentDetailRow(
            icon: appointmentTypeIcon(appointment.type),
            label: context.l10n.type,
            value: appointmentTypeLabel(context.l10n,appointment.type),
          ),

          const _DetailDivider(),

          // DATE & TIME
          AppointmentDetailRow(
            icon: Icons.calendar_today_outlined,
            label: context.l10n.dateAndTime,
            value:'$date - $time'
          ),

          const _DetailDivider(),

          // VETERINARIAN
          AppointmentDetailRow(
            icon: Icons.person_outline_rounded,
            label: context.l10n.veterinarian,
            value: appointment.veterinarian.isNotEmpty
                ? appointment.veterinarian
                : context.l10n.notSpecified,
          ),

          const _DetailDivider(),

          // NOTES
          AppointmentDetailRow(
            icon: Icons.sticky_note_2_outlined,
            label: context.l10n.notes,
            value: appointment.notes.isNotEmpty
                ? appointment.notes
                : context.l10n.noNotesAdded,
            isNotes: true,
          ),
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

  const AppointmentDetailRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.isNotes = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
      child: Row(
        crossAxisAlignment: isNotes
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: context.colors.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, size: 20, color: context.colors.primary),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    color: context.colors.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  value,
                  style: isNotes
                      ? TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          height: 1.45,
                          color: context.colors.onSurfaceVariant,
                        )
                      : TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w800,
                          color: context.colors.onSurface,
                        ),
                ),
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

  const AppointmentActionButton({
    super.key,
    required this.onTap,
    required this.icon,
    required this.iconColor,
    required this.textColor,
    required this.text,
    required this.backgroundColor,
    this.border,
    this.hasShadow = false,
  });

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
          boxShadow: hasShadow
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: iconColor),
            SizedBox(width: 8.w),
            Text(
              text,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailDivider extends StatelessWidget {
  const _DetailDivider();

  @override
  Widget build(BuildContext context) => Divider(
    height: 1,
    thickness: 1,
    color: context.colors.outlineVariant,
    indent: 16,
    endIndent: 16,
  );
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
        color: context.colors.outlineVariant,
        child: url.isEmpty
            ? Icon(Icons.pets, color: context.colors.onSurfaceVariant, size: 24)
            : Image.network(
                url,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Icon(
                  Icons.pets,
                  color: context.colors.onSurfaceVariant,
                  size: 24,
                ),
              ),
      ),
    );
  }
}
