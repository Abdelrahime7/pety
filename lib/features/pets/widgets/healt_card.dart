

import 'package:flutter/material.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/core/constant/theme/app_style.dart';
import 'package:pet_care/features/pets/widgets/health_item.dart';

class HealthCard extends StatelessWidget {
  const HealthCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.health_and_safety_outlined,
                  size: 19,
                  color: AppColors.text,
                ),
              ),

              const SizedBox(width: 12),

              Text(
                'Health',
                style: AppStyle.tileTitle,
              ),
            ],
          ),

          const SizedBox(height: 18),

          Row(
            children: [
              const Expanded(
                child: HealthItem(
                  icon: Icons.vaccines_outlined,
                  title: 'Vaccinations',
                  value: 'Up to date',
                ),
              ),

              const SizedBox(width: 12),

              const Expanded(
                child: HealthItem(
                  icon: Icons.calendar_month_outlined,
                  title: 'Appointment',
                  value: 'Not scheduled',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}