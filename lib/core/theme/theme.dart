import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/core/theme/styles/text_styles.dart';

/// "Edge Neural" dark theme.
///
/// Palette: deep obsidian neutrals + vibrant Purple LED primary.
/// Typography: Geist headlines / Inter body.
/// Elevation: tonal layers + glassmorphism, no heavy drop-shadows.
final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  fontFamily: AppTextStyle.fontFamily,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.backgroundBase,

  // ── Color scheme ──────────────────────────────────────────────────────────
  colorScheme: const ColorScheme.dark(
    brightness: Brightness.dark,
    // Primary — Purple LED
    primary: AppColors.primary,
    onPrimary: AppColors.black,
    primaryContainer: AppColors.primaryContainer,
    onPrimaryContainer: AppColors.primaryLight,
    // Secondary — soft violet
    secondary: AppColors.secondary,
    onSecondary: AppColors.black,
    secondaryContainer: AppColors.secondaryDark,
    onSecondaryContainer: AppColors.secondaryLight,
    // Tertiary — Cyber Blue
    tertiary: AppColors.tertiary,
    onTertiary: AppColors.black,
    tertiaryContainer: AppColors.tertiaryContainer,
    onTertiaryContainer: AppColors.tertiary,
    // Error
    error: AppColors.negative,
    onError: AppColors.black,
    errorContainer: AppColors.negativeContainer,
    onErrorContainer: AppColors.negative,
    // Surfaces
    surface: AppColors.surface,
    onSurface: AppColors.onSurface,
    onSurfaceVariant: AppColors.onSurfaceVariant,
    surfaceContainerLowest: AppColors.backgroundBase,
    surfaceContainerLow: AppColors.surface,
    surfaceContainer: AppColors.surfaceContainer,
    surfaceContainerHigh: AppColors.surfaceContainerHigh,
    surfaceContainerHighest: AppColors.surfaceContainerHighest,
    // Outlines
    outline: AppColors.outline,
    outlineVariant: AppColors.outlineVariant,
    // Inverse
    inverseSurface: AppColors.onSurface,
    onInverseSurface: AppColors.surfaceContainer,
    inversePrimary: AppColors.primaryDark,
  ),

  // ── AppBar ────────────────────────────────────────────────────────────────
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.backgroundBase,
    surfaceTintColor: Colors.transparent,
    shadowColor: Colors.transparent,
    titleTextStyle: AppTextStyle.appBarTitle,
    iconTheme: IconThemeData(color: AppColors.onSurface),
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: false,
  ),

  // ── Bottom Sheet ──────────────────────────────────────────────────────────
  // Glassmorphism: dark surface with 20px backdrop blur handled in component.
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: AppColors.surfaceContainer,
    surfaceTintColor: Colors.transparent,
    modalBackgroundColor: AppColors.surfaceContainer,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
    ),
    dragHandleColor: AppColors.outline,
  ),

  // ── Divider ───────────────────────────────────────────────────────────────
  dividerTheme: const DividerThemeData(
    color: AppColors.surfaceBorder,
    thickness: 1,
    space: 0,
  ),

  // ── Cards ─────────────────────────────────────────────────────────────────
  cardTheme: CardThemeData(
    color: AppColors.surface,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12), // rounded-xl
      side: const BorderSide(color: AppColors.surfaceBorder, width: 1),
    ),
    margin: EdgeInsets.zero,
  ),

  // ── Input Decoration ──────────────────────────────────────────────────────
  // Darkest charcoal + Geist font; focus border → primary purple + glow.
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.backgroundBase,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    hintStyle: AppTextStyle.bodyMd.copyWith(color: AppColors.outline),
    labelStyle: AppTextStyle.labelMd.copyWith(color: AppColors.onSurfaceVariant),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4), // 0.25rem
      borderSide: const BorderSide(color: AppColors.outlineVariant, width: 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(color: AppColors.outlineVariant, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(color: AppColors.negative, width: 1),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(color: AppColors.negative, width: 1.5),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(color: AppColors.disabled, width: 1),
    ),
  ),

  // ── Elevated / Text / Outlined Buttons ────────────────────────────────────
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.black,
      disabledBackgroundColor: AppColors.disabled,
      disabledForegroundColor: AppColors.outline,
      textStyle: AppTextStyle.primaryButtonText,
      minimumSize: const Size(64, 48),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      elevation: 0,
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.primary,
      disabledForegroundColor: AppColors.outline,
      textStyle: AppTextStyle.secondaryButtonText,
      side: const BorderSide(color: AppColors.ghostBorder, width: 1),
      minimumSize: const Size(64, 48),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.primary,
      textStyle: AppTextStyle.secondaryButtonText,
    ),
  ),

  // ── Chip ──────────────────────────────────────────────────────────────────
  chipTheme: ChipThemeData(
    backgroundColor: AppColors.surfaceContainerHigh,
    labelStyle: AppTextStyle.labelSm,
    side: const BorderSide(color: AppColors.outlineVariant, width: 1),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99)),
  ),

  // ── List Tile ────────────────────────────────────────────────────────────
  listTileTheme: const ListTileThemeData(
    tileColor: AppColors.surface,
    selectedTileColor: AppColors.surfaceContainerHigh,
    iconColor: AppColors.onSurfaceVariant,
    textColor: AppColors.onSurface,
    subtitleTextStyle: TextStyle(
      fontFamily: AppTextStyle.bodyFontFamily,
      fontSize: 13,
      color: AppColors.onSurfaceVariant,
    ),
    shape: Border(
      top: BorderSide(color: AppColors.surfaceBorder, width: 1),
    ),
  ),

  // ── Circular Progress Indicator ───────────────────────────────────────────
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: AppColors.primary,
  ),

  // ── Icon ─────────────────────────────────────────────────────────────────
  iconTheme: const IconThemeData(color: AppColors.onSurfaceVariant),
  primaryIconTheme: const IconThemeData(color: AppColors.primary),

  // ── Text theme ────────────────────────────────────────────────────────────
  textTheme: const TextTheme(
    displayLarge: AppTextStyle.headlineLg,
    displayMedium: AppTextStyle.headlineLgMobile,
    displaySmall: AppTextStyle.headlineMd,
    headlineLarge: AppTextStyle.headlineLg,
    headlineMedium: AppTextStyle.headlineLgMobile,
    headlineSmall: AppTextStyle.headlineMd,
    titleLarge: AppTextStyle.headlineMd,
    titleMedium: AppTextStyle.labelMd,
    titleSmall: AppTextStyle.labelSm,
    bodyLarge: AppTextStyle.bodyLg,
    bodyMedium: AppTextStyle.bodyMd,
    bodySmall: AppTextStyle.body12,
    labelLarge: AppTextStyle.labelMd,
    labelMedium: AppTextStyle.labelSm,
    labelSmall: AppTextStyle.labelSm,
  ),
);
