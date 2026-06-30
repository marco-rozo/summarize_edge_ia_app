import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/core/theme/styles/text_styles.dart';

final ThemeData appTheme = ThemeData(
  fontFamily: AppTextStyle.fontFamily,
  scaffoldBackgroundColor: AppColors.backgroundLightSecondary,
  colorScheme: const ColorScheme.light(
    primary: AppColors.primaryLight,
    secondary: AppColors.secondaryLight,
    error: AppColors.negative,
    onSurfaceVariant: AppColors.dragHandle,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.primaryLight,
    titleTextStyle: AppTextStyle.appBarTitle,
    iconTheme: IconThemeData(color: AppColors.white),
    elevation: 0,
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: AppColors.backgroundLightSecondary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
  ),
);
