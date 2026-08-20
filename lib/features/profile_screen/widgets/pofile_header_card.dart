import 'package:flutter/material.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/core/constant/theme/app_style.dart';
import 'package:pet_care/core/constant/widgets/widhT_widget.dart';
class ProfileHeaderCard extends StatelessWidget {
  const ProfileHeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar with Camera Badge
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: const Color(0xFFE8F5F1), width: 3),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(19),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=300&q=80',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: -2,
                right: -2,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Icon(
                    Icons.camera_alt_rounded,
                    color: Colors.white,
                    size: 13,
                  ),
                ),
              ),
            ],
          ),
          const WidhtSpace(width: 14),

          // User Info & Plan Badge
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Sarah Jenkins',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyle.headerName,
                ),
                const SizedBox(height: 2),
                Text(
                  'sarah.j@example.com',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyle.regular13,
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F4F8),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: Color(0xFFF5B731),
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text('FREE PLAN', style: AppStyle.planBadge),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const WidhtSpace(width: 8),

          // Settings Action Button
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(
                Icons.settings_rounded,
                color: Color(0xFF5B6B82),
                size: 20,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
