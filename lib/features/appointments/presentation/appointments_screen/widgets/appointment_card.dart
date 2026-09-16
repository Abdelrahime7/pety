import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pet_care/core/constant/routers/app_routers.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/features/appointments/domain/entity/appointment.dart';
import 'package:pet_care/features/pets/riverpod/pet_provider.dart';

/// A single appointment row/card. Resolves the pet photo and name dynamically from [appointment.petId].
/// Renders differently based on [appointment.status] (upcoming vs past).
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

    // Dynamically retrieve pet and its picture from petId
    final pet = ref.watch(petByIdProvider(appointment.petId));
    final petPhotoUrl = pet?.photoUrl ?? '';
    final petName = pet?.name ?? 'Pet';

    final accentColor = AppColors.primary;
    final doctor = appointment.veterinarian.trim();
    final title = doctor.isEmpty
      ? 'Appointment — $petName'
      : '$doctor — $petName';

    return InkWell(
      onTap: onTap ?? () => context.push(appointmentDetails, extra: appointment),
      borderRadius: BorderRadius.circular(14),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isPast ? const Color(0xFFF9FAFB) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border(
            left: BorderSide(
              color: isPast ? const Color(0xFFD1D5DB) : accentColor,
              width: 4,
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
            _PetAvatar(photoUrl: petPhotoUrl, isPast: isPast),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: isPast ? AppColors.textSecondary : AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    doctor.isEmpty ? 'Veterinarian not provided' : doctor,
                    style: TextStyle(fontSize: 12, color: AppColors.secondaryText),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (appointment.notes.trim().isNotEmpty) ...[
                    const SizedBox(height: 3),
                    Text(
                      appointment.notes,
                      style: TextStyle(fontSize: 11, color: AppColors.textMuted),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const SizedBox(height: 6),
                  if (isPast)
                    Text(
                      'Completed ${DateFormat('MMM d, yyyy').format(appointment.date)}',
                      style: TextStyle(fontSize: 12, color: AppColors.secondaryText),
                    )
                  else
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          size: 12,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          DateFormat('MMM d, yyyy').format(appointment.date),
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Icon(
                          Icons.access_time,
                          size: 12,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          DateFormat('h:mm a').format(appointment.date),
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            isPast
                ? Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFE5E7EB),
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 14,
                      color: AppColors.textSecondary,
                    ),
                  )
                : IconButton(
                    icon: const Icon(Icons.more_horiz, size: 20),
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

  const _PetAvatar({required this.photoUrl, required this.isPast});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isPast ? 0.5 : 1.0,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.antiAlias,
        child: photoUrl.isNotEmpty
            ? Image.network(
                photoUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.pets,
                  size: 20,
                  color: AppColors.icon,
                ),
              )
            : const Icon(
                Icons.pets,
                size: 20,
                color: AppColors.icon,
              ),
      ),
    );
  }
}