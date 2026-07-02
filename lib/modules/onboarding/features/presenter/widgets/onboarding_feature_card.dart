import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/modules/onboarding/features/presenter/widgets/card/feature_card_content.dart';
import 'package:summary_app/modules/onboarding/features/presenter/widgets/card/feature_card_icon.dart';
import 'package:summary_app/modules/onboarding/features/presenter/widgets/onboarding_step_data.dart';

class OnboardingFeatureCard extends StatelessWidget {
  const OnboardingFeatureCard({super.key, required this.data});

  final OnboardingStepData data;

  @override
  Widget build(BuildContext context) {
    final Color iconColor = data.iconColor ?? AppColors.tertiary;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.surfaceBorder,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FeatureCardIcon(
            icon: data.icon,
            color: iconColor,
          ),
          const SizedBox(height: 16),
          FeatureCardContent(
            title: data.title,
            description: data.description,
          ),
        ],
      ),
    );
  }
}
