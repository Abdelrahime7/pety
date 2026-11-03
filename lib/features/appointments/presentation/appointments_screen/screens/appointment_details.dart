import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/core/constant/routers/routes_strings.dart';
import 'package:pet_care/core/constant/theme/context_x.dart';
import 'package:pet_care/features/appointments/domain/entity/appointment.dart';
import 'package:pet_care/features/appointments/presentation/appointments_screen/widgets/appointment_details_widgets.dart';
import 'package:pet_care/features/appointments/presentation/riverpod/appointment_provider.dart';
import 'package:pet_care/features/pets/riverpod/pet_provider.dart';

import 'package:pet_care/core/constant/l10n/l10x.dart';
class AppointmentDetailsScreen extends ConsumerStatefulWidget {
  final Appointment appointment;

  const AppointmentDetailsScreen({super.key, required this.appointment});

  @override
  ConsumerState<AppointmentDetailsScreen> createState() =>
      _AppointmentDetailsScreenState();
}

class _AppointmentDetailsScreenState
    extends ConsumerState<AppointmentDetailsScreen> {
  late Appointment _appointment;

  @override
  void initState() {
    super.initState();
    _appointment = widget.appointment;
  }

  Future<void> _openEdit() async {
    final updated = await context.push<Appointment>(
      appointmentEdit,
      extra: _appointment,
    );

    if (updated != null && mounted) {
      setState(() => _appointment = updated);
    }
  }

  @override
  Widget build(BuildContext context) {
    final pet = ref.watch(petByIdProvider(_appointment.petId));
    final isPast = _appointment.status == AppointmentStatus.past;

    return Scaffold(
      backgroundColor: context.colors.surface,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
          child: Column(
            children: [
              AppointmentDetailsTopBar(onEdit: _openEdit),
              SizedBox(height: 18.h),
              AppointmentPetCard(pet: pet, isPast: isPast),
              SizedBox(height: 16.h),
              AppointmentInfoCard(appointment: _appointment),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: AppointmentActionButton(
                      onTap: _openEdit,
                      icon: Icons.edit_outlined,
                      iconColor: context.colors.primary,
                      textColor: context.colors.onSurface,
                      text: context.l10n.edit,
                      backgroundColor: context.colors.surfaceContainer,
                      border: Border.all(
                        color: context.colors.outlineVariant,
                        width: 1.2,
                      ),
                      hasShadow: true,
                    ),
                  ),
                  SizedBox(width: 14.w),
                  Expanded(
                    child: AppointmentActionButton(
                      onTap: () => _delete(context),
                      icon: Icons.delete_outline_rounded,
                      iconColor: context.colors.error,
                      textColor: context.colors.error,
                      text: context.l10n.cancel,
                      backgroundColor: context.colors.error.withValues(
                        alpha: 0.12,
                      ),
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

  Future<void> _delete(BuildContext context) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.r),
        ),
        title: Text(
          context.l10n.cancelAppointmentTitle,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(
          context.l10n.cancelAppointmentMessage,
        ),
        actions: [
          TextButton(
            onPressed: () => dialogContext.pop(false),
            child: Text(context.l10n.keep),
          ),
          FilledButton(
            onPressed: () => dialogContext.pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: context.colors.error,
            ),
            child: Text(context.l10n.cancelVisit),
          ),
        ],
      ),
    );

    if (shouldDelete != true || !context.mounted) return;

    final result = await ref
        .read(appointmentProvider.notifier)
        .deleteAppointment(_appointment.appointmentId);
    if (!context.mounted) return;

    if (result is Success<void>) {
      context.pop();
    } else if (result is Failure<void>) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(result.message)));
    }
  }
}