import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_care/core/constant/routers/routes_strings.dart';
import 'package:pet_care/core/constant/theme/context_x.dart';
import 'package:pet_care/features/appointments/domain/entity/appointment.dart';
import 'package:pet_care/features/appointments/presentation/riverpod/appointment_provider.dart';
import 'package:pet_care/features/appointments/presentation/appointments_screen/widgets/week_day_selector.dart';
import 'package:pet_care/features/appointments/presentation/appointments_screen/widgets/appointment_card.dart';

import 'package:pet_care/core/constant/l10n/l10x.dart';
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
    final startOfWeek = _selectedDay.subtract(
      Duration(days: _selectedDay.weekday - 1),
    );
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
      backgroundColor: context.colors.surface,
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
                        context.l10n.appointments,
                        style: TextStyle(
                          fontSize: 21.sp,
                          fontWeight: FontWeight.w900,
                          color: context.colors.onSurface,
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
                      decoration: BoxDecoration(
                        color: context.colors.primary,
                        shape: BoxShape.circle,
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x332DD4BF),
                            blurRadius: 12,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child:  Icon(
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
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton(
                  onPressed: () => setState(() => _showAllAppointments = true),
                  style: TextButton.styleFrom(
                    foregroundColor: context.colors.primary,
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    context.l10n.all,
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
                      return Center(
                        child: CircularProgressIndicator(
                          color: context.colors.primary,
                        ),
                      );
                    }

                    if (appointmentState.error != null) {
                      return Center(
                        child: Text(context.l10n.errorWithMessage('${appointmentState.error}')),
                      );
                    }

                    if (filteredAppointments.isEmpty) {
                      return Center(
                        child: Text(
                          _showAllAppointments
                              ? context.l10n.noAppointmentsYet
                              : context.l10n.noAppointmentsOnDay,
                          style: TextStyle(
                            color: context.colors.onSurfaceVariant,
                          ),
                        ),
                      );
                    }

                    return ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        if (upcoming.isNotEmpty) ...[
                          _SectionHeader(title: context.l10n.upcoming),
                          ...upcoming.map(
                            (a) => AppointmentCard(appointment: a),
                          ),
                        ],
                        if (past.isNotEmpty) ...[
                          _SectionHeader(title: context.l10n.past),
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
          letterSpacing: context.tracking(0.5),
          color: context.colors.onSurfaceVariant,
        ),
      ),
    );
  }
}