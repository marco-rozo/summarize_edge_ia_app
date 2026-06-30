import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/core/theme/styles/text_styles.dart';

enum MyAppButtonTypeEnum {
  primary(
    backgroundColor: AppColors.primaryLight,
    borderColor: AppColors.primaryLight,
    progressIndicatorColor: AppColors.backgroundLightPrimary,
    textStyle: AppTextStyle.primaryButtonText,
    disabledColor: AppColors.disabled,
    splashColor: AppColors.primary,
  ),
  secondary(
    backgroundColor: AppColors.backgroundLightPrimary,
    borderColor: AppColors.borderLight,
    progressIndicatorColor: AppColors.primary,
    textStyle: AppTextStyle.secondaryButtonText,
    disabledColor: AppColors.disabled,
    splashColor: AppColors.backgroundLightSecondary,
  ),
  negative(
    backgroundColor: AppColors.negative,
    borderColor: AppColors.negative,
    progressIndicatorColor: AppColors.backgroundLightPrimary,
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
