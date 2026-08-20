import 'package:flutter/material.dart';

abstract final class AppColors {
  static const background = Color(0xFFF8FAF8);
  static const surface = Colors.white;

  static const textPrimary = Color(0xFF1B1B1B);
  static const textSecondary = Color(0xFF6B7280);
  static const textMuted = Color(0xFF94A3B8); // Muted / placeholder / caption text color

  static const error = Color(0xFFD32F2F);

  static const primary = Color(0xFF2DD4BF);
  static const text = Color(0xFF0F172A);
  static const secondaryText = Color(0xFF94A3B8);
  static const border = Color(0xFFE5E7EB);
  static const icon = Color(0xFF9CA3AF);

  // Individual Gradient Stop Colors
  static const Color tealDark = Color(0xFF0F766E);
  static const Color tealLight = Color(0xFF2DD4BF);

  // Ready-to-use Linear Gradient
  static const LinearGradient premiumCardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [tealDark, tealLight],
  );
}