import 'package:flutter/material.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'dart:io';


class ProfilePictureWidget extends StatelessWidget {
  final String? imageUrl;
  final File? imageFile;
  final VoidCallback? onEdit;
  final double size;

  const ProfilePictureWidget({
    super.key,
    this.imageUrl,
    this.imageFile,
    this.onEdit,
    this.size = 72,
  });

  @override
  Widget build(BuildContext context) {
    final double borderRadius = size * 0.3;
    final double innerRadius = borderRadius - 2;

    Widget image;

    // 1. Show newly selected local image first
    if (imageFile != null) {
      image = Image.file(
        imageFile!,
        fit: BoxFit.cover,
      );
    }

    // 2. Otherwise show image from server
    else if (imageUrl != null && imageUrl!.isNotEmpty) {
      image = Image.network(
        imageUrl!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stack) {
          return Icon(
            Icons.person,
            color: const Color(0xFFCBD5E1),
            size: size * 0.55,
          );
        },
      );
    }

    // 3. No image
    else {
      image = Icon(
        Icons.person,
        color: const Color(0xFFCBD5E1),
        size: size * 0.55,
      );
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: const Color(0xFFF0FDFA),
              width: size > 80 ? 4 : 3,
            ),
            color: const Color(0xFFF1F5F9),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(innerRadius),
            child: image,
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
                border: Border.all(
                  color: Colors.white,
                  width: size > 80 ? 4 : 2,
                ),
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