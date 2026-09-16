import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/core/constant/routers/app_routers.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/features/appointments/domain/entity/appointment.dart';
import 'package:pet_care/features/appointments/presentation/appointments_screen/widgets/appointment_details_widgets.dart';
import 'package:pet_care/features/appointments/presentation/riverpod/appointment_provider.dart';
import 'package:pet_care/features/pets/riverpod/pet_provider.dart';

class AppointmentDetailsScreen extends ConsumerWidget {
  final Appointment appointment;

  const AppointmentDetailsScreen({super.key, required this.appointment});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pet = ref.watch(petByIdProvider(appointment.petId));
    final isPast = appointment.status == AppointmentStatus.past;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
          child: Column(
            children: [
              AppointmentDetailsTopBar(
                onEdit: () => context.push(appointmentEdit, extra: appointment),
              ),
              SizedBox(height: 18.h),
              AppointmentPetCard(pet: pet, isPast: isPast),
              SizedBox(height: 16.h),
              AppointmentInfoCard(appointment: appointment),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: AppointmentActionButton(
                      onTap: () => context.push(appointmentEdit, extra: appointment),
                      icon: Icons.edit_outlined,
                      iconColor: AppColors.primary,
                      textColor: AppColors.textPrimary,
                      text: 'Edit',
                      backgroundColor: Colors.white,
                      border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
                      hasShadow: true,
                    ),
                  ),
                  SizedBox(width: 14.w),
                  Expanded(
                    child: AppointmentActionButton(
                      onTap: () => _delete(context, ref),
                      icon: Icons.delete_outline_rounded,
                      iconColor: const Color(0xFFEF4444),
                      textColor: const Color(0xFFEF4444),
                      text: 'Cancel',
                      backgroundColor: const Color(0xFFFEE2E2),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.r)),
        title: const Text('Cancel Appointment?', style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text('Are you sure you want to cancel this appointment? This action cannot be undone.'),
        actions: [
          TextButton(onPressed: () => dialogContext.pop(false), child: const Text('Keep')),
          FilledButton(
            onPressed: () => dialogContext.pop(true),
            style: FilledButton.styleFrom(backgroundColor: const Color(0xFFEF4444)),
            child: const Text('Cancel Visit'),
          ),
        ],
      ),
    );

    if (shouldDelete != true || !context.mounted) return;

    final result = await ref.read(appointmentProvider.notifier).deleteAppointment(appointment.appointmentId);
    if (!context.mounted) return;

    if (result is Success<void>) {
      context.pop();
    } else if (result is Failure<void>) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result.message)));
    }
  }
}
