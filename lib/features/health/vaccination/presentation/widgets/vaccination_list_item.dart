import 'package:pet_care/core/constant/theme/context_x.dart';

import 'package:flutter/material.dart';

class VaccinationListItem extends StatelessWidget {
  final String vaccineName;
  final int requiredDoses;
  final int completedDoses;
  final VoidCallback? onTap;

  const VaccinationListItem({
    super.key,
    required this.vaccineName,
    required this.requiredDoses,
    required this.completedDoses,
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
            color: context.colors.surface,
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
                  color: context.colors.primary.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  Icons.vaccines_rounded,
                  size: 23,
                  color: context.colors.primary,
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
                      style: context.style.tileTitle.copyWith(fontSize: 14),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      ' $completedDoses/$requiredDoses ${completedDoses == 1 ? 'dose' : 'doses'} compelted',
                      style: context.style.regular12.copyWith(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: context.colors.primary.withValues(alpha: 0.08),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.chevron_right_rounded,
                  size: 21,
                  color: context.colors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
