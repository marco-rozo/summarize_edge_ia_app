import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/core/theme/styles/text_styles.dart';
import 'package:summary_app/modules/ai_models/features/presenter/cubits/ai_models_cubit.dart';
import 'package:summary_app/modules/ai_models/features/presenter/widgets/active_runtime_spec_row.dart';

class ActiveRuntimePanel extends StatelessWidget {
  final AiModelUIState? activeModel;

  const ActiveRuntimePanel({super.key, this.activeModel});

  @override
  Widget build(BuildContext context) {
    final modelInfo = activeModel?.modelInfo;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'EXECUÇÃO ATIVA',
          style: AppTextStyle.labelSm.copyWith(
            color: AppColors.onSurfaceVariant,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.surface.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.surfaceBorder, width: 1),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.1),
                blurRadius: 24,
                spreadRadius: -4,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: activeModel != null
                              ? AppColors.primary
                              : AppColors.outline,
                          boxShadow: activeModel != null
                              ? [
                                  BoxShadow(
                                    color: AppColors.primary.withValues(
                                      alpha: 0.6,
                                    ),
                                    blurRadius: 8,
                                  ),
                                ]
                              : null,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        modelInfo?.name ?? 'Nenhum em uso',
                        style: AppTextStyle.headlineMd.copyWith(
                          color: AppColors.onSurface,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.bolt_rounded,
                    color: activeModel != null
                        ? AppColors.primary
                        : AppColors.outline,
                    size: 28,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ActiveRuntimeSpecRow(
                label: 'ARQUITETURA',
                value: modelInfo?.formattedArchitecture ?? 'Transformer',
              ),
              ActiveRuntimeSpecRow(
                label: 'PARÂMETROS',
                value: modelInfo?.parameterCount ?? '-',
              ),
              ActiveRuntimeSpecRow(
                label: 'QUANTIZAÇÃO',
                value: modelInfo?.version != null
                    ? 'LiteRT (${modelInfo!.version})'
                    : 'Int8 / Q4',
              ),
              ActiveRuntimeSpecRow(
                label: 'MEMÓRIA REQ.',
                value: modelInfo?.formattedSizeInRam ?? '0.0 MB RAM',
                isLast: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.surfaceBorder),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.info_outline_rounded,
                color: AppColors.tertiary,
                size: 22,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Aceleração de Hardware',
                      style: AppTextStyle.labelMd.copyWith(
                        color: AppColors.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Aceleração via Metal (Apple Silicon) e Android NNAPI está ativada, proporcionando a máxima velocidade de inferência offline.',
                      style: AppTextStyle.labelSm.copyWith(
                        color: AppColors.onSurfaceVariant,
                        height: 1.4,
                        letterSpacing: 0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

}

