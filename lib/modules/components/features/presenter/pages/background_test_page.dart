import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/core/theme/components/summary_app_background/summary_app_background.dart';
import 'package:summary_app/core/theme/components/summary_app_button/summary_app_button.dart';
import 'package:summary_app/core/theme/styles/text_styles.dart';

class BackgroundTestPage extends StatelessWidget {
  const BackgroundTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Teste de Background'),
      ),
      body: Stack(
        children: [
          const SummaryAppBackground(),
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.auto_awesome,
                      size: 64,
                      color: AppColors.primaryLight,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Componente SummaryAppBackground',
                      style: AppTextStyle.headlineMd.copyWith(
                        color: AppColors.onSurface,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Este é o novo background compartilhado do sistema, com grade técnica e brilho LED em um Stack.',
                      style: AppTextStyle.bodyMd.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 48),
                    SummaryAppButton.secondary(
                      text: 'Voltar para Componentes',
                      leftIcon: Icons.arrow_back_rounded,
                      onPressed: () => context.pop(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
