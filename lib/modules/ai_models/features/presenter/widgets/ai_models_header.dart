import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/core/theme/styles/text_styles.dart';

class AiModelsHeader extends StatelessWidget {
  const AiModelsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.sizeOf(context).width < 600;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gerenciamento de Modelos',
          style: isSmallScreen
              ? AppTextStyle.headlineLgMobile
              : AppTextStyle.headlineLg,
        ),
        const SizedBox(height: 8),
        Text(
          'Gerencie modelos de IA para processamento offline no dispositivo.',
          style: AppTextStyle.bodyMd.copyWith(
            color: AppColors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
