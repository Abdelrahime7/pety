import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/core/constant/routers/app_routers.dart';

import 'package:pet_care/features/home/presentation%20/widgets/quick_action_card.dart';
import 'package:pet_care/core/constant/routers/routes_strings.dart';


class QuickActionsSection extends StatelessWidget {
  const QuickActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12.w,
      mainAxisSpacing: 12.h,
      childAspectRatio: 1.65,
      children: [
        QuickActionCard(
          title: 'Appointments',
          subtitle: 'shedual appointment',
          icon: Icons.calendar_month_rounded,
          iconColor: const Color(0xFF0D9488),
          iconBackground: const Color(0xFFE0F7F3),
          onTap:() {
            appRouter.push(addNewAppointment);
          },
        ),
        QuickActionCard(
          title: 'Health Records',
          subtitle: 'Track health',
          icon: Icons.health_and_safety_outlined,
          iconColor: const Color(0xFF6366F1),
          iconBackground: const Color(0xFFEEF2FF),
          onTap:() {
            appRouter.push(allHealthRecords);
          },
        ),
         QuickActionCard(
          title: 'Vaccinations',
          subtitle: 'vaccines',
          icon: Icons.vaccines_outlined,
          iconColor: Color(0xFFEA580C),
          iconBackground: Color(0xFFFFF1E6),
          onTap:() {
            appRouter.push(allVaccinationsRecords);
          },
        ),
         QuickActionCard(
          title: 'My Pets',
          subtitle: 'Pet profiles',
          icon: Icons.pets_rounded,
          iconColor: Color(0xFFDB2777),
          iconBackground: Color(0xFFFCE7F3),
          onTap:() {
            appRouter.push(petList);
          },
        ),
      ],
    );
  }
}