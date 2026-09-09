
import 'package:flutter/material.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/core/constant/theme/app_style.dart';

class HealthItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const HealthItem({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20,
            color: AppColors.icon,
          ),

          const SizedBox(height: 10),

          Text(
            title,
            style: AppStyle.regular10,
          ),

          const SizedBox(height: 4),

          Text(
            value,
            style: AppStyle.tileTitle.copyWith(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
