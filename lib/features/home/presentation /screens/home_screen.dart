import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/core/constant/routers/app_routers.dart';

import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/core/constant/theme/app_style.dart';
import 'package:pet_care/features/appointments/domain/entity/appointment.dart';
import 'package:pet_care/features/appointments/presentation/riverpod/appointment_provider.dart';
import 'package:pet_care/features/home/presentation%20/widgets/health_summary_section.dart';
import 'package:pet_care/features/home/presentation%20/widgets/home_header.dart';
import 'package:pet_care/features/home/presentation%20/widgets/home_section_header.dart';
import 'package:pet_care/features/home/presentation%20/widgets/pets_section.dart';
import 'package:pet_care/features/home/presentation%20/widgets/quick_actions_section.dart';
import 'package:pet_care/features/home/presentation%20/widgets/upcoming_appointment_card.dart';
import 'package:pet_care/features/pets/riverpod/pet_provider.dart';
import 'package:pet_care/core/constant/routers/routes_strings.dart';



class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState()=>_HomeScreenState();
   

}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final appointments = ref.watch(appointmentProvider).appointments;
    final nearestAppointment = _getNearestAppointment(appointments);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 28.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeHeader(),

              SizedBox(height: 24.h),

             _buildPetsSection(ref),
              SizedBox(height: 28.h),

              HomeSectionHeader(
                title: 'Quick Actions',
                subtitle: 'Everything your pet needs',
              ),

              SizedBox(height: 14.h),

              const QuickActionsSection(),

              SizedBox(height: 28.h),

              HomeSectionHeader(
                title: 'Upcoming Appointment',
                actionText: 'See all',
                onActionTap: () {
                    appRouter.push(calendar);
                },
              ),

              SizedBox(height: 14.h),

               UpcomingAppointmentCard(appointment:nearestAppointment),

              SizedBox(height: 28.h),

              HomeSectionHeader(
                title: 'Health Overview',
                actionText: 'View records',
                onActionTap: () {
                  appRouter.push(health);
                },
              ),

              SizedBox(height: 14.h),

              const HealthSummarySection(),
            ],
          ),
        ),
      ),
    );
  }
}
Widget _buildPetsSection(WidgetRef ref) {
  final petsAsync = ref.watch(petProvider);

  return petsAsync.when(
    loading: () => const Center(
      child: CircularProgressIndicator(),
    ),

    error: (error, stackTrace) => Padding(
      padding: const EdgeInsets.all(20),
      child: Text(
        'Unable to load your pets.',
        style: AppStyle.regular14,
      ),
    ),

    data: (pets) => HomePetsSection(
      pets: pets,
      onPetTap: (pet) {
        appRouter.push(petDetails,extra: pet);
      },
      onSeeAll: () {
        appRouter.push(petList);
      },

      onAddPet: () {
        appRouter.push(addNewPet);

      },
    ),
  );
}
Appointment? _getNearestAppointment(List<Appointment> appointments) {
  final now = DateTime.now();

  final upcomingAppointments = appointments
      .where(
        (appointment) =>
            appointment.status == AppointmentStatus.upcoming &&
            !appointment.date.isBefore(now),
      )
      .toList()
    ..sort((a, b) => a.date.compareTo(b.date));

  return upcomingAppointments.isNotEmpty
      ? upcomingAppointments.first
      : null;
}