import 'package:flutter/material.dart';

import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/core/constant/theme/app_style.dart';

class VaccinationListItem extends StatelessWidget {
  final String vaccineName;
  final String nextDoseDate;
  final String nextDoseStatus;
  final VoidCallback? onTap;

  const VaccinationListItem({
    super.key,
    required this.vaccineName,
    required this.nextDoseDate,
    required this.nextDoseStatus,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isUnscheduled = nextDoseStatus == 'Unscheduled';

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
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.vaccines_rounded,
                  size: 23,
                  color: AppColors.primary,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vaccineName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyle.tileTitle.copyWith(
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      'Next dose: $nextDoseDate',
                      style: AppStyle.regular10,
                    ),

                    if (!isUnscheduled) ...[
                      const SizedBox(height: 5),
                      Text(
                        nextDoseStatus,
                        style: AppStyle.regular10.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(width: 8),

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
        ),
      ),
    );
  }
}