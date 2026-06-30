import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';

final class AppTextStyle {
  AppTextStyle._();

  static const String fontFamily = 'Poppins';

  // Headlines
  static const TextStyle headline10 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: AppColors.textLightPrimary,
  );

  static const TextStyle headline12 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textLightPrimary,
  );

  static const TextStyle headline16 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textLightPrimary,
  );

  static const TextStyle headline20 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.textLightPrimary,
  );

  static const TextStyle headline30 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 30,
    fontWeight: FontWeight.w500,
    color: AppColors.textLightPrimary,
  );

  // Body
  static const TextStyle body12 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textLightSecondary,
  );

  static const TextStyle body14Primary = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textLightPrimary,
    height: 1.75,
  );

  static const TextStyle body14Secondary = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textLightSecondary,
  );

  static const TextStyle body16 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textLightSecondary,
  );

  // Buttons
  static const TextStyle primaryButtonText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textDarkPrimary,
  );

  static const TextStyle secondaryButtonText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textLightPrimary,
  );

  static const TextStyle disabledButtonText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textLightSecondary,
  );

  // AppBar
  static const TextStyle appBarTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.textDarkPrimary,
  );

  // Chat
  static const TextStyle chatMessageUser = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textDarkPrimary,
    height: 1.5,
  );

  static const TextStyle chatMessageAssistant = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textLightPrimary,
    height: 1.5,
  );

  static const TextStyle chatTimestamp = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: AppColors.textLightTertiary,
  );

  static const TextStyle chatInputHint = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textLightTertiary,
  );

  static const TextStyle chatEmptyState = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textLightSecondary,
  );
}
