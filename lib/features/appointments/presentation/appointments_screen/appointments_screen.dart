import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_care/core/constant/routers/app_routers.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/features/appointments/domain/entity/appointment.dart';
import 'package:pet_care/features/appointments/presentation/riverpod/appointment_provider.dart';
import 'package:pet_care/features/appointments/presentation/appointments_screen/widgets/week_day_selector.dart';
import 'package:pet_care/features/appointments/presentation/appointments_screen/widgets/appointment_card.dart';

class AppointmentsScreen extends ConsumerStatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  ConsumerState<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends ConsumerState<AppointmentsScreen> {
  late DateTime _selectedDay;
  late List<DateTime> _weekDays;
  bool _showAllAppointments = true;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    final startOfWeek =
        _selectedDay.subtract(Duration(days: _selectedDay.weekday - 1));
    _weekDays = List.generate(6, (i) => startOfWeek.add(Duration(days: i)));
  }

  @override
  Widget build(BuildContext context) {
    final appointmentState = ref.watch(appointmentProvider);
    final appointments = appointmentState.appointments;

    final filteredAppointments = _showAllAppointments
      ? appointments.toList()
      : appointments.where((appointment) {
        final appointmentDate = appointment.date;
        return appointmentDate.year == _selectedDay.year &&
          appointmentDate.month == _selectedDay.month &&
          appointmentDate.day == _selectedDay.day;
        }).toList();

    final upcoming = filteredAppointments
        .where((a) => a.status == AppointmentStatus.upcoming)
        .toList();
    final past = filteredAppointments
        .where((a) => a.status == AppointmentStatus.past)
        .toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 18.h),

              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Appointments',
                        style: TextStyle(
                          fontSize: 21.sp,
                          fontWeight: FontWeight.w900,
                          color: AppColors.text,
                        ),
                      ),
                    ],
                  ),

                  // Add Button
                  GestureDetector(
                    onTap: () {
                      context.push(addNewAppointment);
                    },
                    child: Container(
                      width: 34.w,
                      height: 34.w,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x332DD4BF),
                            blurRadius: 12,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 21,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 22.h),

              // Week day selector
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => setState(() => _showAllAppointments = true),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'All',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              WeekDaySelector(
                days: _weekDays,
                selectedDay: _showAllAppointments ? null : _selectedDay,
                onDaySelected: (day) => setState(() {
                  _selectedDay = day;
                  _showAllAppointments = false;
                }),
              ),

              SizedBox(height: 8.h),

              // List of appointments
              Expanded(
                child: Builder(
                  builder: (context) {
                    if (appointmentState.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(color: AppColors.primary),
                      );
                    }

                    if (appointmentState.error != null) {
                      return Center(
                        child: Text('Error: ${appointmentState.error}'),
                      );
                    }

                    if (filteredAppointments.isEmpty) {
                      return Center(
                        child: Text(
                            _showAllAppointments
                              ? 'No appointments yet.'
                              : 'No appointments on this day.',
                          style: TextStyle(color: AppColors.secondaryText),
                        ),
                      );
                    }

                    return ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        if (upcoming.isNotEmpty) ...[
                          const _SectionHeader(title: 'Upcoming'),
                          ...upcoming.map((a) => AppointmentCard(appointment: a)),
                        ],
                        if (past.isNotEmpty) ...[
                          const _SectionHeader(title: 'Past'),
                          ...past.map((a) => AppointmentCard(appointment: a)),
                        ],
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
          color: AppColors.secondaryText,
        ),
      ),
    );
  }
}