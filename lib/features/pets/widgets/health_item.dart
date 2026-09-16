
import 'package:flutter/material.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/core/constant/theme/app_style.dart';

class AppointmentItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String nextDueDate;
  final VoidCallback? onTap;

  const AppointmentItem({
    super.key,
    required this.icon,
    required this.title,
    required this.nextDueDate,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Icon(
                      icon,
                      size: 21,
                      color: AppColors.primary,
                    ),
                  ),

                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.08),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.chevron_right_rounded,
                      size: 21,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              Text(
                title,
                style: AppStyle.regular10,
              ),

              const SizedBox(height: 5),

              Text(
                nextDueDate,
                style: AppStyle.tileTitle.copyWith(
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VaccinationItem extends StatelessWidget {
  final IconData icon;
  final String vaccinationsNum;
  final String nextVaccineName;
  final VoidCallback? onTap;

  const VaccinationItem({
    super.key,
    required this.icon,
    required this.vaccinationsNum,
    required this.nextVaccineName,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Icon(
                      icon,
                      size: 21,
                      color: AppColors.primary,
                    ),
                  ),

                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.08),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.chevron_right_rounded,
                      size: 21,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              Text(
                'Vaccinations',
                style: AppStyle.regular10,
              ),

              const SizedBox(height: 5),

              Text(
                vaccinationsNum,
                style: AppStyle.tileTitle.copyWith(
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Next Vaccine',
                style: AppStyle.regular10,
              ),

              const SizedBox(height: 5),

              Text(
                nextVaccineName,
                style: AppStyle.tileTitle.copyWith(
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}