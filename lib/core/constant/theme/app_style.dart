import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  const AppStyle(this.c);
  final ColorScheme c;

  // Headings
  TextStyle get extraBoldTitle => GoogleFonts.poppins(
    fontSize: 26,
    fontWeight: FontWeight.w800,
    color: c.onSurface,
  );

  TextStyle get title => GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: c.onSurface,
  );

  TextStyle get titleWhite => GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: Colors.white, // used on gradients, stays white
    letterSpacing: -0.5,
  );

  TextStyle get subtitle => GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: c.onSurface,
  );

  TextStyle get headerName => GoogleFonts.poppins(
    fontSize: 17,
    fontWeight: FontWeight.w700,
    color: c.onSurface,
    letterSpacing: -0.3,
  );

  // Section headers & badges
  TextStyle get sectionHeader => GoogleFonts.poppins(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: c.onSurfaceVariant,
    letterSpacing: 1.1,
  );

  TextStyle get badgeCapsule => GoogleFonts.poppins(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    letterSpacing: 1.1,
  );

  TextStyle get planBadge => GoogleFonts.poppins(
    fontSize: 10,
    fontWeight: FontWeight.w700,
    color: c.onSurfaceVariant, // was fixed 0xFF5B6B82
    letterSpacing: 0.4,
  );

  // Body & tile text
  TextStyle get tileTitle => GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: c.onSurface,
  );

  TextStyle get buttonText => GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: c.primary,
  );

  TextStyle get promoSubtitle => GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.white.withValues(alpha: 0.85),
    height: 1.4,
  );

  TextStyle get regular14 => _regular(14);
  TextStyle get regular13 => _regular(13);
  TextStyle get regular12 => _regular(12);
  TextStyle get regular10 => _regular(10);

  TextStyle _regular(double size) => GoogleFonts.poppins(
    fontSize: size,
    fontWeight: FontWeight.w400,
    color: c.onSurfaceVariant,
  );
}
