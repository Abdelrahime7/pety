import 'package:pet_care/core/constant/theme/context_x.dart';

import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const InfoCard({
    super.key,
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: context.colors.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.025),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
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
                child: Icon(icon, size: 18, color: context.colors.onSurface),
              ),

              const SizedBox(width: 12),

              Text(title, style: context.style.tileTitle),
            ],
          ),

          const SizedBox(height: 20),

          ...children,
        ],
      ),
    );
  }
}
