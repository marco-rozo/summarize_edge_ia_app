import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';

/// Text styles for the "Edge Neural" design system.
///
/// Dual-font approach:
///   • **Geist** — headlines & labels (developer-tool aesthetic).
///   • **Inter**  — body copy & AI-generated summaries (max legibility).
final class AppTextStyle {
  AppTextStyle._();

  // ── Font families ─────────────────────────────────────────────────────────
  static const String fontFamily = 'Geist';
  static const String bodyFontFamily = 'Inter';

  // ── Headlines (Geist) ─────────────────────────────────────────────────────

  /// headline-lg · 40px · Bold · -0.02em — desktop hero title
  static const TextStyle headlineLg = TextStyle(
    fontFamily: fontFamily,
    fontSize: 40,
    fontWeight: FontWeight.w700,
    color: AppColors.onSurface,
    height: 1.2,         // 48px / 40px
    letterSpacing: -0.8, // -0.02em × 40px
  );

  /// headline-lg-mobile · 30px · Bold · -0.02em
  static const TextStyle headlineLgMobile = TextStyle(
    fontFamily: fontFamily,
    fontSize: 30,
    fontWeight: FontWeight.w700,
    color: AppColors.onSurface,
    height: 1.2,
    letterSpacing: -0.6,
  );

  /// headline-md · 24px · SemiBold · -0.01em
  static const TextStyle headlineMd = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurface,
    height: 1.333, // 32px / 24px
    letterSpacing: -0.24,
  );

  // ── Labels (Geist, uppercase + wide tracking) ─────────────────────────────

  /// label-md · 14px · Medium · +0.05em — nav, tabs, small CTAs
  static const TextStyle labelMd = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.onSurface,
    height: 1.428, // 20px / 14px
    letterSpacing: 0.7, // 0.05em × 14px
  );

  /// label-sm · 12px · SemiBold · +0.08em — metadata, status chips (UPPERCASE)
  static const TextStyle labelSm = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurfaceVariant,
    height: 1.333, // 16px / 12px
    letterSpacing: 0.96, // 0.08em × 12px
  );

  // ── Body (Inter) ──────────────────────────────────────────────────────────

  /// body-lg · 18px · Regular — AI summaries
  static const TextStyle bodyLg = TextStyle(
    fontFamily: bodyFontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.onSurface,
    height: 1.555, // 28px / 18px
  );

  /// body-md · 16px · Regular — general body copy
  static const TextStyle bodyMd = TextStyle(
    fontFamily: bodyFontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.onSurface,
    height: 1.5, // 24px / 16px
  );

  // ── Buttons ───────────────────────────────────────────────────────────────

  static const TextStyle primaryButtonText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.black, // black on solid purple
    letterSpacing: 0.3,
  );

  static const TextStyle secondaryButtonText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.primary, // purple text for ghost button
    letterSpacing: 0.3,
  );

  static const TextStyle disabledButtonText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.outline,
    letterSpacing: 0.3,
  );

  // ── AppBar ────────────────────────────────────────────────────────────────

  static const TextStyle appBarTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurface,
    letterSpacing: -0.18,
  );

  // ── Legacy aliases (backward compat) ─────────────────────────────────────
  static const TextStyle headline10 = TextStyle(
    fontFamily: fontFamily, fontSize: 10, fontWeight: FontWeight.w500,
    color: AppColors.onSurface,
  );
  static const TextStyle headline12 = TextStyle(
    fontFamily: fontFamily, fontSize: 12, fontWeight: FontWeight.w500,
    color: AppColors.onSurface,
  );
  static const TextStyle headline16 = TextStyle(
    fontFamily: fontFamily, fontSize: 16, fontWeight: FontWeight.w500,
    color: AppColors.onSurface,
  );
  static const TextStyle headline20 = TextStyle(
    fontFamily: fontFamily, fontSize: 20, fontWeight: FontWeight.w600,
    color: AppColors.onSurface,
  );
  static const TextStyle headline30 = headlineLgMobile;

  static const TextStyle body12 = TextStyle(
    fontFamily: bodyFontFamily, fontSize: 12, fontWeight: FontWeight.w400,
    color: AppColors.onSurfaceVariant,
  );
  static const TextStyle body14Primary = TextStyle(
    fontFamily: bodyFontFamily, fontSize: 14, fontWeight: FontWeight.w400,
    color: AppColors.onSurface, height: 1.75,
  );
  static const TextStyle body14Secondary = TextStyle(
    fontFamily: bodyFontFamily, fontSize: 14, fontWeight: FontWeight.w400,
    color: AppColors.onSurfaceVariant,
  );
  static const TextStyle body16 = bodyMd;
}
