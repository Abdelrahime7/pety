
import 'package:pet_care/core/constant/l10n/l10x.dart';
import 'package:pet_care/core/constant/l10n/to_english_digit.dart';
import 'package:pet_care/core/constant/theme/context_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pet_care/core/constant/routers/routes_strings.dart';
import 'package:pet_care/features/appointments/domain/entity/appointment.dart';
import 'package:pet_care/features/pets/riverpod/pet_provider.dart';

/// A compact appointment summary card.
///
/// Shows only the information needed to identify an appointment:
/// - Pet
/// - Veterinarian
/// - Date & time
/// - Status
///
/// Full appointment information is available on [AppointmentDetailsScreen].
class AppointmentCard extends ConsumerWidget {
  final Appointment appointment;
  final VoidCallback? onTap;
  final VoidCallback? onMorePressed;

  const AppointmentCard({
    super.key,
    required this.appointment,
    this.onTap,
    this.onMorePressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPast = appointment.status == AppointmentStatus.past;

    final pet = ref.watch(petByIdProvider(appointment.petId));

    final petPhotoUrl = pet?.photoUrl ?? '';
    final petName = pet?.name ?? context.l10n.pet;

    final doctor = appointment.veterinarian.trim();
    final title = doctor.isEmpty
        ? context.l10n.appointmentWithPet(petName)
        : context.l10n.doctorWithPet(doctor, petName);

    final date = toEnglishDigits(
      DateFormat('EEE, MMM d, yyyy', context.l10n.localeName)
          .format(appointment.date),
    );

    final time = toEnglishDigits(
      DateFormat('h:mm a', context.l10n.localeName)
          .format(appointment.date),
    );

    return InkWell(
      onTap: onTap ??
          () => context.push(appointmentDetails, extra: appointment),
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: isPast
              ? context.colors.surfaceContainerLow
              : context.colors.surfaceContainer,
          borderRadius: BorderRadius.circular(14.r),
          border: Border(
            left: BorderSide(
              color: isPast
                  ? context.colors.outlineVariant
                  : context.colors.primary,
              width: 4.w,
            ),
          ),
          boxShadow: isPast
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Row(
          children: [
            _PetAvatar(
              photoUrl: petPhotoUrl,
              isPast: isPast,
            ),

            SizedBox(width: 12.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                      color: isPast
                          ? context.colors.onSurfaceVariant
                          : context.colors.onSurface,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: 8.h),

                  if (isPast)
                    Text(
                      context.l10n.completedOn(
                        toEnglishDigits(
                          DateFormat(
                            'MMM d, yyyy',
                            context.l10n.localeName,
                          ).format(appointment.date),
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: context.colors.onSurfaceVariant,
                      ),
                    )
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Appointment date
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 12.sp,
                              color: context.colors.primary,
                            ),
                            SizedBox(width: 4.w),
                            Expanded(
                              child: Text(
                                date,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: context.colors.onSurfaceVariant,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 6.h),

                        // Appointment time
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 12.sp,
                              color: context.colors.primary,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              time,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: context.colors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                ],
              ),
            ),

            SizedBox(width: 8.w),

            if (isPast)
              Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.colors.outlineVariant,
                ),
                child: Icon(
                  Icons.check,
                  size: 14.sp,
                  color: context.colors.onSurfaceVariant,
                ),
              )
            else
              IconButton(
                icon: Icon(Icons.more_horiz, size: 20.sp),
                onPressed: onMorePressed,
              ),
          ],
        ),
      ),
    );
  }
}

class _PetAvatar extends StatelessWidget {
  final String photoUrl;
  final bool isPast;

  const _PetAvatar({
    required this.photoUrl,
    required this.isPast,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isPast ? 0.5 : 1.0,
      child: Container(
        width: 44.w,
        height: 44.w,
        decoration: BoxDecoration(
          color: context.colors.outlineVariant,
          borderRadius: BorderRadius.circular(12.r),
        ),
        clipBehavior: Clip.antiAlias,
        child: photoUrl.isNotEmpty
            ? Image.network(
                photoUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Icon(
                  Icons.pets,
                  size: 20.sp,
                  color: context.colors.onSurfaceVariant,
                ),
              )
            : Icon(
                Icons.pets,
                size: 20.sp,
                color: context.colors.onSurfaceVariant,
              ),
      ),
    );
  }
}
