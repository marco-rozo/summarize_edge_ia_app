import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/core/theme/styles/text_styles.dart';
import 'package:summary_app/modules/onboarding/features/presenter/widgets/hero/onboarding_brand_icon.dart';

class OnboardingHeroSection extends StatelessWidget {
  const OnboardingHeroSection({
    super.key,
    required this.isLarge,
  });

  final bool isLarge;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const OnboardingBrandIcon(),
        const SizedBox(height: 48),
        Text(
          'Sua IA, Seu Controle.',
          textAlign: TextAlign.center,
          style: isLarge
              ? AppTextStyle.headlineLg.copyWith(
                  color: AppColors.primaryLight,
                )
              : AppTextStyle.headlineLgMobile.copyWith(
                  color: AppColors.primaryLight,
                ),
        ),
        if (isLarge) ...[
          const SizedBox(height: 16),
          Text(
            'Gere resumos precisos usando processamento de IA direto no seu dispositivo. Privacidade garantida.',
            textAlign: TextAlign.center,
            style: AppTextStyle.bodyLg.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }
}
