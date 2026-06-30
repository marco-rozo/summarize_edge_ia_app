import 'package:flutter/material.dart';

final class AppColors {
  AppColors._();

  // Primary — base: #3D348B (HSL 246°, 46%, 38%)
  static const Color primary = Color(0xFF3D348B);
  static const Color primaryLight = Color(0xFF6259B3); // HSL 246°, 42%, 54%
  static const Color primaryDark = Color(0xFF241D62);  // HSL 246°, 51%, 24%

  // Secondary — base: #7678ED (HSL 239°, 79%, 63%)
  static const Color secondary = Color(0xFF7678ED);
  static const Color secondaryLight = Color(0xFFA3A4F4); // HSL 239°, 84%, 79%
  static const Color secondaryDark = Color(0xFF4D50C8);  // HSL 239°, 57%, 49%

  // Background
  static const Color backgroundLightPrimary = Color(0xFFFFFFFF);
  static const Color backgroundLightSecondary = Color(0xFFF6F6F6);
  static const Color backgroundLightTertiary = Color(0xFFEDEDED);

  // Text
  static const Color textLightPrimary = Color(0xFF2B2B2B);
  static const Color textLightSecondary = Color(0xFF787878);
  static const Color textLightTertiary = Color(0xFFABABAB);
  static const Color textDarkPrimary = Color(0xFFFFFFFF);

  // Borders
  static const Color borderLight = Color(0xFFC7C7C7);
  static const Color borderDivider = Color(0xFFE6E0E9);

  // States
  static const Color negative = Color(0xFFE11900);
  static const Color positive = Color(0xFF05944F);
  static const Color warning = Color(0xFFD2761B);
  static const Color disabled = Color(0xFFD9D9D9);

  // Misc
  static const Color dragHandle = Color(0xFF79747E);
  static const Color transparent = Colors.transparent;
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
}
