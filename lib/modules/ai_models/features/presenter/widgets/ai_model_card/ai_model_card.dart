import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/core/theme/styles/text_styles.dart';
import 'package:summary_app/modules/ai_models/features/presenter/cubits/ai_models_cubit.dart';
import 'package:summary_app/modules/ai_models/features/presenter/widgets/ai_model_card/ai_model_main_info.dart';
import 'package:summary_app/modules/ai_models/features/presenter/widgets/ai_model_card/ai_model_status_and_actions.dart';

class AiModelCard extends StatelessWidget {
  final AiModelUIState uiState;
  final bool isActiveRuntime;

  const AiModelCard({
    super.key,
    required this.uiState,
    required this.isActiveRuntime,
  });

  @override
  Widget build(BuildContext context) {
    final model = uiState.modelInfo;
    final cubit = context.read<AiModelsCubit>();
    final isDownloading =
        uiState.downloadProgress > 0.0 && uiState.downloadProgress < 1.0;
    final isOffline = !uiState.isDownloaded && !isDownloading;

    Color borderColor = AppColors.surfaceBorder;
    if (isActiveRuntime) {
      borderColor = AppColors.primary;
    } else if (isDownloading) {
      borderColor = AppColors.primary.withValues(alpha: 0.3);
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color: isDownloading
              ? AppColors.surfaceContainerHigh
              : AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: borderColor,
            width: isActiveRuntime ? 1.5 : 1,
          ),
          boxShadow: isActiveRuntime
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.08),
                    blurRadius: 12,
                  ),
                ]
              : null,
        ),
        child: Stack(
          children: [
            if (isActiveRuntime)
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: Container(width: 4, color: AppColors.primary),
              ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isWide = constraints.maxWidth >= 550;
                      if (isWide) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: AiModelMainInfo(
                                model: model,
                                isOffline: isOffline,
                                isDownloading: isDownloading,
                                isActiveRuntime: isActiveRuntime,
                              ),
                            ),
                            if (!isDownloading) ...[
                              const SizedBox(width: 24),
                              AiModelStatusAndActions(
                                uiState: uiState,
                                isActiveRuntime: isActiveRuntime,
                                isWide: true,
                              ),
                            ],
                          ],
                        );
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AiModelMainInfo(
                              model: model,
                              isOffline: isOffline,
                              isDownloading: isDownloading,
                              isActiveRuntime: isActiveRuntime,
                            ),
                            if (!isDownloading) ...[
                              const SizedBox(height: 20),
                              Container(
                                width: double.infinity,
                                alignment: Alignment.centerLeft,
                                child: AiModelStatusAndActions(
                                  uiState: uiState,
                                  isActiveRuntime: isActiveRuntime,
                                  isWide: false,
                                ),
                              ),
                            ],
                          ],
                        );
                      }
                    },
                  ),
                  if (isDownloading) ...[
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.sync_rounded,
                              color: AppColors.primary,
                              size: 16,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Baixando...',
                              style: AppTextStyle.labelSm.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '${(uiState.downloadProgress * 100).toInt()}%',
                          style: AppTextStyle.labelSm.copyWith(
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: uiState.downloadProgress,
                              minHeight: 6,
                              backgroundColor: AppColors.surfaceContainer,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        IconButton(
                          icon: const Icon(
                            Icons.close_rounded,
                            color: AppColors.onSurfaceVariant,
                          ),
                          tooltip: 'Cancelar download',
                          onPressed: () => cubit.deleteModel(uiState),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
