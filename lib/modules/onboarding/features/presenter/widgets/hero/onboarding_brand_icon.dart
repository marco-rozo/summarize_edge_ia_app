import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';

class OnboardingBrandIcon extends StatelessWidget {
  const OnboardingBrandIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.surfaceBorder,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryLight.withValues(alpha: 0.30),
            blurRadius: 15,
            spreadRadius: 0,
          ),
        ],
      ),
      child: const Icon(
        Icons.memory_rounded,
        color: AppColors.primaryLight,
        size: 32,
      ),
    );
  }
}
