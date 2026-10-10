import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hetman_boxing_club/app/theme/app_colors.dart';

abstract final class AppTypography {
  static TextStyle display(
    double size, {
    Color color = AppColors.textPrimary,
    FontStyle style = FontStyle.italic,
  }) {
    return GoogleFonts.barlowCondensed(
      fontSize: size,
      height: 0.92,
      fontWeight: FontWeight.w800,
      fontStyle: style,
      letterSpacing: 0.2,
      color: color,
    );
  }

  static TextStyle title(
    double size, {
    Color color = AppColors.textPrimary,
  }) {
    return GoogleFonts.barlowCondensed(
      fontSize: size,
      height: 1,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.3,
      color: color,
    );
  }

  static TextStyle button({Color color = Colors.white, double size = 15}) {
    return GoogleFonts.barlowCondensed(
      fontSize: size,
      fontWeight: FontWeight.w700,
      letterSpacing: 1.05,
      color: color,
    );
  }

  static TextStyle body({
    double size = 15,
    Color color = AppColors.textSecondary,
    FontWeight weight = FontWeight.w500,
    double height = 1.5,
  }) {
    return GoogleFonts.manrope(
      fontSize: size,
      fontWeight: weight,
      height: height,
      color: color,
    );
  }

  static TextStyle label({
    double size = 12,
    Color color = AppColors.textMuted,
    double spacing = 1.15,
  }) {
    return GoogleFonts.barlowCondensed(
      fontSize: size,
      fontWeight: FontWeight.w600,
      letterSpacing: spacing,
      color: color,
    );
  }
}
