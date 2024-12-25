import 'package:flutter/material.dart';

/// Class to represent the colors of a brand.
class BrandColors {
  final Color primary;
  final Color secondary;
  final Color error;
  final Color warning;
  final Color info;
  final Color success;
  final Color textPrimary;
  final Color textSecondary;

  const BrandColors({
    required this.primary,
    required this.secondary,
    required this.error,
    required this.warning,
    required this.info,
    required this.success,
    required this.textPrimary,
    required this.textSecondary,
  });
}

/// ThemeColors class to store predefined color schemes for different brands.
class ThemeColors {
  static const BrandColors main = grab;

  /// Grab color scheme.
  static const BrandColors grab = BrandColors(
    primary: Color(0xFF00B14F),
    secondary: Color(0xFFF6F7F9),
    error: Color(0xFFD0021B),
    warning: Color(0xFFF5A623),
    info: Color(0xFF2A73E0),
    success: Color(0xFF00B14F),
    textPrimary: Color(0xFF212121),
    textSecondary: Color(0xFF757575),
  );

  /// Gojek color scheme.
  static const BrandColors gojek = BrandColors(
    primary: Color(0xFF00880C),
    secondary: Color(0xFFE5E5E5),
    error: Color(0xFFEB5757),
    warning: Color(0xFFF2C94C),
    info: Color(0xFF2D9CDB),
    success: Color(0xFF00880C),
    textPrimary: Color(0xFF000000),
    textSecondary: Color(0xFF828282),
  );
}
