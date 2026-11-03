import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  const AppStyle(this.c, {this.arabic = false});
  final ColorScheme c;

  /// When true, Cairo is used (Poppins has no Arabic letters) and letter
  /// spacing is removed, because it breaks joined Arabic letters.
  final bool arabic;

  TextStyle _f({
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    double? letterSpacing,
    double? height,
  }) {
    return arabic
        ? GoogleFonts.cairo(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color,
            height: height,
          )
        : GoogleFonts.poppins(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color,
            letterSpacing: letterSpacing,
            height: height,
          );
  }

  // Headings
  TextStyle get extraBoldTitle => _f(
    fontSize: 26,
    fontWeight: FontWeight.w800,
    color: c.onSurface,
  );

  TextStyle get title => _f(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: c.onSurface,
  );

  TextStyle get titleWhite => _f(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: Colors.white, // used on gradients, stays white
    letterSpacing: -0.5,
  );

  TextStyle get subtitle => _f(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: c.onSurface,
  );

  TextStyle get headerName => _f(
    fontSize: 17,
    fontWeight: FontWeight.w700,
    color: c.onSurface,
    letterSpacing: -0.3,
  );

  // Section headers & badges
  TextStyle get sectionHeader => _f(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: c.onSurfaceVariant,
    letterSpacing: 1.1,
  );

  TextStyle get badgeCapsule => _f(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    letterSpacing: 1.1,
  );

  TextStyle get planBadge => _f(
    fontSize: 10,
    fontWeight: FontWeight.w700,
    color: c.onSurfaceVariant, // was fixed 0xFF5B6B82
    letterSpacing: 0.4,
  );

  // Body & tile text
  TextStyle get tileTitle => _f(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: c.onSurface,
  );

  TextStyle get buttonText => _f(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: c.primary,
  );

  TextStyle get promoSubtitle => _f(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.white.withValues(alpha: 0.85),
    height: 1.4,
  );

  TextStyle get regular14 => _regular(14);
  TextStyle get regular13 => _regular(13);
  TextStyle get regular12 => _regular(12);
  TextStyle get regular10 => _regular(10);

  TextStyle _regular(double size) => _f(
    fontSize: size,
    fontWeight: FontWeight.w400,
    color: c.onSurfaceVariant,
  );
}