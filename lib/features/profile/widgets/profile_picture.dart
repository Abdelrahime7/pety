import 'package:flutter/material.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';

class ProfilePictureWidget extends StatelessWidget {
  final String? imageUrl;
  final VoidCallback? onEdit;
  final double size;

  const ProfilePictureWidget({
    super.key,
    this.imageUrl,
    this.onEdit,
    this.size = 72,
  });

  @override
  Widget build(BuildContext context) {
    final double borderRadius = size * 0.3; // Responsive curve proportionally
    final double innerRadius = borderRadius - 2;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: const Color(0xFFF0FDFA), width: size > 80 ? 4 : 3),
            color: const Color(0xFFF1F5F9), // Subtle background for fallback
            boxShadow: [
              if (size > 80)
                 BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)
            ]
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(innerRadius),
            child: imageUrl != null && imageUrl!.isNotEmpty
                ? Image.network(
                    imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stack) => Icon(
                      Icons.person, color: const Color(0xFFCBD5E1), size: size * 0.55
                    ),
                  )
                : Icon(Icons.person, color: const Color(0xFFCBD5E1), size: size * 0.55),
          ),
        ),
        Positioned(
          bottom: size > 80 ? -4 : -2,
          right: size > 80 ? -4 : -2,
          child: GestureDetector(
            onTap: onEdit,
            child: Container(
              width: size > 80 ? 36 : 24,
              height: size > 80 ? 36 : 24,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: size > 80 ? 4 : 2),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4)
                ],
              ),
              child: Icon(
                Icons.camera_alt_rounded,
                color: Colors.white,
                size: size > 80 ? 14 : 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
