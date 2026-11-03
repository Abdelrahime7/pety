import 'package:pet_care/core/constant/theme/context_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/core/constant/routers/app_routers.dart';

import 'package:pet_care/features/home/presentation/widgets/quick_action_card.dart';
import 'package:pet_care/core/constant/routers/routes_strings.dart';

import 'package:pet_care/core/constant/l10n/l10x.dart';
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
          title: context.l10n.appointments,
          subtitle: context.l10n.scheduleVisits,
          icon: Icons.calendar_month_rounded,
          iconColor: context.colors.primary,
          iconBackground: context.colors.primary.withValues(alpha: 0.12),
          onTap: () {
            appRouter.push(addNewAppointment);
          },
        ),
        QuickActionCard(
          title: context.l10n.healthRecords,
          subtitle: context.l10n.trackHealth,
          icon: Icons.health_and_safety_outlined,
          iconColor: const Color(0xFF6366F1),
          iconBackground: const Color(0xFFEEF2FF),
          onTap: () {
            appRouter.push(allHealthRecords);
          },
        ),
        QuickActionCard(
          title: context.l10n.vaccinations,
          subtitle: context.l10n.vaccines,
          icon: Icons.vaccines_outlined,
          iconColor: Color(0xFFEA580C),
          iconBackground: Color(0xFFFFF1E6),
          onTap: () {
            appRouter.push(allVaccinationsRecords);
          },
        ),
        QuickActionCard(
          title: context.l10n.myPets,
          subtitle: context.l10n.petProfiles,
          icon: Icons.pets_rounded,
          iconColor: Color(0xFFDB2777),
          iconBackground: Color(0xFFFCE7F3),
          onTap: () {
            appRouter.push(petList);
          },
        ),
      ],
    );
  }
}