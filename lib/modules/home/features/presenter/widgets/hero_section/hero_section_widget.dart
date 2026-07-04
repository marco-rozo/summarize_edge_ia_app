import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/core/theme/components/summary_app_button/summary_app_button.dart';
import 'package:summary_app/core/theme/styles/text_styles.dart';
import 'package:summary_app/modules/home/features/presenter/widgets/hero_section/hero_feature_badge_widget.dart';

class HeroSectionWidget extends StatefulWidget {
  const HeroSectionWidget({super.key, this.onStartNewSummary});

  final VoidCallback? onStartNewSummary;

  @override
  State<HeroSectionWidget> createState() => _HeroSectionWidgetState();
}

class _HeroSectionWidgetState extends State<HeroSectionWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Badge "SISTEMA PRONTO"
        Container(
          margin: const EdgeInsets.only(bottom: 24),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerHigh,
            border: Border.all(color: AppColors.surfaceBorder, width: 1),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (context, child) {
                  return Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.tertiary,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.tertiary.withValues(
                            alpha: _pulseAnimation.value * 0.8,
                          ),
                          blurRadius: 6,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(width: 8),
              Text(
                'SISTEMA PRONTO',
                style: AppTextStyle.labelSm.copyWith(
                  color: AppColors.tertiary,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
        ),

        // Título Principal
        Text(
          'Análise e Síntese de Dados Locais',
          textAlign: TextAlign.center,
          style: AppTextStyle.headlineLg.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.8,
          ),
        ),
        const SizedBox(width: 16, height: 16),

        // Subtítulo
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 580),
          child: Text(
            'Gere resumos precisos de documentos técnicos e atas de reunião usando processamento de IA direto no seu dispositivo. Privacidade garantida.',
            textAlign: TextAlign.center,
            style: AppTextStyle.bodyLg.copyWith(
              color: AppColors.onSurfaceVariant,
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 40),

        // Botão Central de Ação usando componente compartilhado da aplicação
        SummaryAppButton.tertiaryFill(
          width: 260,
          leftIcon: Icons.mic_rounded,
          text: 'Iniciar Novo Resumo',
          onPressed: widget.onStartNewSummary ?? () {},
        ),
        const SizedBox(height: 32),

        // Recursos Offline / Latência Zero
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HeroFeatureBadgeWidget(
              icon: Icons.lock_outline_rounded,
              label: 'Offline',
            ),
            SizedBox(width: 24),
            HeroFeatureBadgeWidget(
              icon: Icons.speed_rounded,
              label: 'Latência Zero',
            ),
          ],
        ),
      ],
    );
  }
}
