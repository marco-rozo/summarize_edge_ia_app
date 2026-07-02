import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/core/theme/styles/text_styles.dart';

/// Button variant tokens for the "Edge Neural" design system.
///
/// - **primary** — solid Purple LED (#A855F7) with black text + glow.
/// - **secondary / ghost** — transparent with a 1px purple-tinted border.
/// - **negative** — error/destructive action.
enum MyAppButtonTypeEnum {
  primary(
    backgroundColor: AppColors.primary,
    borderColor: AppColors.primary,
    progressIndicatorColor: AppColors.black,
    textStyle: AppTextStyle.primaryButtonText,
    disabledColor: AppColors.disabled,
    splashColor: AppColors.primaryContainer,
  ),
  secondary(
    // Ghost: transparent bg + subtle purple border
    backgroundColor: AppColors.transparent,
    borderColor: AppColors.ghostBorder,
    progressIndicatorColor: AppColors.primary,
    textStyle: AppTextStyle.secondaryButtonText,
    disabledColor: AppColors.disabled,
    splashColor: AppColors.surfaceContainerHigh,
  ),
  tertiary(
    backgroundColor: AppColors.transparent,
    borderColor: AppColors.borderLight,
    progressIndicatorColor: AppColors.primary,
    textStyle: AppTextStyle.tertiaryButtonText,
    disabledColor: AppColors.disabled,
    splashColor: AppColors.surfaceContainerHigh,
  ),
  negative(
    backgroundColor: AppColors.negativeContainer,
    borderColor: AppColors.negativeContainer,
    progressIndicatorColor: AppColors.onSurface,
    textStyle: AppTextStyle.primaryButtonText,
    disabledColor: AppColors.disabled,
    splashColor: AppColors.negative,
  );

  final Color backgroundColor;
  final Color borderColor;
  final Color progressIndicatorColor;
  final Color disabledColor;
  final TextStyle textStyle;
  final Color splashColor;

  const MyAppButtonTypeEnum({
    required this.backgroundColor,
    required this.borderColor,
    required this.progressIndicatorColor,
    required this.disabledColor,
    required this.textStyle,
    required this.splashColor,
  });
}
