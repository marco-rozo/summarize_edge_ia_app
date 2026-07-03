import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/core/theme/styles/text_styles.dart';

enum SummaryAppButtonTypeEnum {
  primary(
    backgroundColor: AppColors.primary,
    borderColor: AppColors.primary,
    progressIndicatorColor: AppColors.black,
    textStyle: AppTextStyle.primaryButtonText,
    disabledColor: AppColors.disabled,
    splashColor: AppColors.primaryLight,
  ),
  secondary(
    backgroundColor: AppColors.transparent,
    borderColor: AppColors.ghostBorder,
    progressIndicatorColor: AppColors.primary,
    textStyle: AppTextStyle.secondaryButtonText,
    disabledColor: AppColors.disabled,
    splashColor: AppColors.surfaceContainerHigh,
  ),
  tertiaryFill(
    backgroundColor: AppColors.primaryLight,
    borderColor: AppColors.primaryLight,
    progressIndicatorColor: AppColors.black,
    textStyle: AppTextStyle.primaryButtonText,
    disabledColor: AppColors.disabled,
    splashColor: AppColors.surfaceContainerHigh,
  ),
  tertiaryBorder(
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
    progressIndicatorColor: Color.fromARGB(255, 53, 50, 49),
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

  const SummaryAppButtonTypeEnum({
    required this.backgroundColor,
    required this.borderColor,
    required this.progressIndicatorColor,
    required this.disabledColor,
    required this.textStyle,
    required this.splashColor,
  });
}
