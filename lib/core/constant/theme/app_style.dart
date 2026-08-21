import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';

abstract class AppStyle {
  // Headings
  static TextStyle extraBoldTitle = GoogleFonts.poppins(
    fontSize: 26,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
  );

  static TextStyle title = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static TextStyle titleWhite = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    letterSpacing: -0.5,
  );

  static TextStyle subtitle = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static TextStyle headerName = GoogleFonts.poppins(
    fontSize: 17,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.3,
  );

  // Section Headers & Badges
  static TextStyle sectionHeader = GoogleFonts.poppins(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: AppColors.secondaryText,
    letterSpacing: 1.1,
  );

  static TextStyle badgeCapsule = GoogleFonts.poppins(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    letterSpacing: 1.1,
  );

  static TextStyle planBadge = GoogleFonts.poppins(
    fontSize: 10,
    fontWeight: FontWeight.w700,
    color: const Color(0xFF5B6B82),
    letterSpacing: 0.4,
  );

  // Body & Tile Text
  static TextStyle tileTitle = GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  );

  static TextStyle buttonText = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.primary,
  );

  static TextStyle promoSubtitle = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.white.withOpacity(0.85),
    height: 1.4,
  );

  static TextStyle regular14 = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static TextStyle regular13 = GoogleFonts.poppins(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static TextStyle regular12 = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static TextStyle regular10 = GoogleFonts.poppins(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );
}
