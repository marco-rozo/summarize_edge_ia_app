import 'package:flutter/material.dart';

/// Color palette for the "Edge Neural" design system.
/// Anchored in deep obsidian neutrals with vibrant neon accents.
final class AppColors {
  AppColors._();

  // ── Primary — "Purple LED" #A855F7 ──────────────────────────────────────
  static const Color primary = Color(0xFFA855F7);
  static const Color primaryLight = Color(0xFFDDB7FF);  // M3 primary-fixed-dim
  static const Color primaryDark = Color(0xFF6900B3);   // M3 on-primary-fixed-variant
  static const Color primaryContainer = Color(0xFFB76DFF);

  // ── Secondary — Soft violet #C084FC ─────────────────────────────────────
  static const Color secondary = Color(0xFFC084FC);
  static const Color secondaryLight = Color(0xFFDDB8FF); // M3 secondary-fixed-dim
  static const Color secondaryDark = Color(0xFF62259B);  // M3 secondary-container

  // ── Tertiary — "Cyber Blue" #22D3EE ─────────────────────────────────────
  static const Color tertiary = Color(0xFF22D3EE);
  static const Color tertiaryContainer = Color(0xFF009FB4);

  // ── Backgrounds / Surfaces ───────────────────────────────────────────────
  /// Void / base layer — #0B0B0B (Pitch)
  static const Color backgroundBase = Color(0xFF0B0B0B);

  /// Carbon — elevated cards & containers — #121212
  static const Color surface = Color(0xFF121212);

  /// Slightly brighter surface for modals / panels
  static const Color surfaceContainer = Color(0xFF201F1F);
  static const Color surfaceContainerLow = Color(0xFF1C1B1B);
  static const Color surfaceContainerHigh = Color(0xFF2A2A2A);
  static const Color surfaceContainerHighest = Color(0xFF353534);

  /// Glass overlay tint for bottom-sheets / sidebars
  static const Color glassOverlay = Color(0xB20B0B0B); // rgba(11,11,11,0.7)

  // ── On-Surface Text ──────────────────────────────────────────────────────
  /// Primary text on dark surfaces — #E5E2E1
  static const Color onSurface = Color(0xFFE5E2E1);

  /// Secondary / muted text — #CFC2D6
  static const Color onSurfaceVariant = Color(0xFFCFC2D6);

  // ── Borders / Outlines ───────────────────────────────────────────────────
  static const Color outline = Color(0xFF988D9F);
  static const Color outlineVariant = Color(0xFF4D4354);

  /// Subtle 1px border for surfaces — rgba(255,255,255,0.05)
  static const Color surfaceBorder = Color(0x0DFFFFFF);

  /// Ghost-button border — rgba(168,85,247,0.4)
  static const Color ghostBorder = Color(0x66A855F7);

  // ── Drag handle / Misc ───────────────────────────────────────────────────
  static const Color dragHandle = Color(0xFF988D9F);

  // ── States ───────────────────────────────────────────────────────────────
  static const Color negative = Color(0xFFFFB4AB);       // M3 error
  static const Color negativeContainer = Color(0xFF93000A);
  static const Color positive = Color(0xFF22D3EE);        // reuse cyber-blue for "ready"
  static const Color warning = Color(0xFFD2761B);
  static const Color disabled = Color(0xFF4D4354);        // dim outline-variant

  // ── Status LED ───────────────────────────────────────────────────────────
  /// Pulsing purple — AI processing
  static const Color ledProcessing = Color(0xFFA855F7);

  /// Solid cyan — Model ready
  static const Color ledReady = Color(0xFF22D3EE);

  /// Dim gray — Offline / not available
  static const Color ledOffline = Color(0xFF4D4354);

  // ── Neutral constants ────────────────────────────────────────────────────
  static const Color transparent = Colors.transparent;
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);

  // ── Legacy aliases (keep for backward compat) ────────────────────────────
  static const Color backgroundLightPrimary = backgroundBase;
  static const Color backgroundLightSecondary = surface;
  static const Color backgroundLightTertiary = surfaceContainer;
  static const Color textLightPrimary = onSurface;
  static const Color textLightSecondary = onSurfaceVariant;
  static const Color textLightTertiary = outline;
  static const Color textDarkPrimary = onSurface;
  static const Color borderLight = outlineVariant;
  static const Color borderDivider = outlineVariant;
}
