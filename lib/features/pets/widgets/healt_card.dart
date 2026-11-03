import 'package:pet_care/core/constant/theme/context_x.dart';

import 'package:flutter/material.dart';
import 'package:pet_care/core/constant/routers/app_routers.dart';
import 'package:pet_care/features/health/vaccination/domain/entities/helath_card_info.dart';
import 'package:pet_care/features/pets/widgets/health_item.dart';
import 'package:pet_care/core/constant/routers/routes_strings.dart';

import 'package:pet_care/core/constant/l10n/l10x.dart';
class HealthCard extends StatelessWidget {
  final String petId;
  final HealthCardInfo cardInfo;
  const HealthCard({super.key, required this.cardInfo, required this.petId});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: context.colors.outlineVariant),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: context.colors.surface,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  Icons.health_and_safety_outlined,
                  size: 19,
                  color: context.colors.onSurface,
                ),
              ),

              const SizedBox(width: 12),

              Text(context.l10n.health, style: context.style.tileTitle),
            ],
          ),

          const SizedBox(height: 18),

          Row(
            children: [
              Expanded(
                child: VaccinationItem(
                  icon: Icons.vaccines_outlined,
                  vaccinationsCount: cardInfo.vaccination.doseCount,
                  activeSeriesCount: cardInfo.vaccination.activeSeriesCount,
                  onTap: () => appRouter.push(vaccinationList, extra: petId),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: AppointmentItem(
                  icon: Icons.calendar_month_outlined,
                  title: context.l10n.appointment,
                  nextDueDate: context.l10n.notScheduled,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}