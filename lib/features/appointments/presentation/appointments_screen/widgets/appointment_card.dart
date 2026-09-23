import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pet_care/core/constant/routers/app_routers.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';
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

    final pet = ref.watch(
      petByIdProvider(appointment.petId),
    );

    final petPhotoUrl = pet?.photoUrl ?? '';
    final petName = pet?.name ?? 'Pet';

    final doctor = appointment.veterinarian.trim();

    final title = doctor.isEmpty
        ? 'Appointment — $petName'
        : '$doctor — $petName';

    return InkWell(
      onTap: onTap ??
          () => context.push(
                appointmentDetails,
                extra: appointment,
              ),
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: isPast
              ? const Color(0xFFF9FAFB)
              : Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border(
            left: BorderSide(
              color: isPast
                  ? const Color(0xFFD1D5DB)
                  : AppColors.primary,
              width: 4.w,
            ),
          ),
          boxShadow: isPast
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
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
                          ? AppColors.textSecondary
                          : AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: 8.h),

                  if (isPast)
                    Text(
                      'Completed ${DateFormat('MMM d, yyyy').format(appointment.date)}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.secondaryText,
                      ),
                    )
                  else
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 12.sp,
                          color: AppColors.primary,
                        ),
                        SizedBox(width: 4.w),

                        Text(
                          DateFormat(
                            'MMM d, yyyy',
                          ).format(appointment.date),
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.textSecondary,
                          ),
                        ),

                        SizedBox(width: 12.w),

                        Icon(
                          Icons.access_time,
                          size: 12.sp,
                          color: AppColors.primary,
                        ),
                        SizedBox(width: 4.w),

                        Text(
                          DateFormat(
                            'h:mm a',
                          ).format(appointment.date),
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.textSecondary,
                          ),
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
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFE5E7EB),
                ),
                child: Icon(
                  Icons.check,
                  size: 14.sp,
                  color: AppColors.textSecondary,
                ),
              )
            else
              IconButton(
                icon: Icon(
                  Icons.more_horiz,
                  size: 20.sp,
                ),
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
          color: const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(12.r),
        ),
        clipBehavior: Clip.antiAlias,
        child: photoUrl.isNotEmpty
            ? Image.network(
                photoUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Icon(
                  Icons.pets,
                  size: 20.sp,
                  color: AppColors.icon,
                ),
              )
            : Icon(
                Icons.pets,
                size: 20.sp,
                color: AppColors.icon,
              ),
      ),
    );
  }
}