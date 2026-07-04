import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/core/theme/components/summary_app_button/summary_app_button.dart';
import 'package:summary_app/core/theme/styles/text_styles.dart';

class HomePageErrorBodyWidget extends StatelessWidget {
  const HomePageErrorBodyWidget({super.key, required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Center(
        child: Column(
          children: [
            const Icon(
              Icons.error_outline_rounded,
              color: AppColors.negative,
              size: 32,
            ),
            const SizedBox(height: 12),
            Text(
              'Erro ao carregar resumos recentes.',
              style: AppTextStyle.bodyMd.copyWith(
                color: AppColors.negative,
              ),
            ),
            const SizedBox(height: 16),
            SummaryAppButton.primary(
              width: 220,
              leftIcon: Icons.refresh_rounded,
              text: 'Tentar novamente',
              onPressed: onRetry,
            ),
          ],
        ),
      ),
    );
  }
}
