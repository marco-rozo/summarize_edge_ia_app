import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/core/theme/styles/text_styles.dart';
import 'package:summary_app/modules/ai_models/features/presenter/cubits/ai_models_cubit.dart';
import 'package:summary_app/modules/ai_models/features/presenter/widgets/ai_model_card/ai_model_card.dart';

class AvailableLibraryPanel extends StatelessWidget {
  final List<AiModelUIState> models;
  final Set<String> activeModelIds;

  const AvailableLibraryPanel({
    super.key,
    required this.models,
    this.activeModelIds = const {},
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'BIBLIOTECA DISPONÍVEL',
              style: AppTextStyle.labelSm.copyWith(
                color: AppColors.onSurfaceVariant,
                letterSpacing: 1.5,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainer,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '${models.length} ${models.length == 1 ? "ITEM" : "ITENS"}',
                style: AppTextStyle.labelSm.copyWith(
                  fontSize: 10,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (models.isEmpty)
          Container(
            padding: const EdgeInsets.all(40),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.surfaceBorder),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.folder_open_rounded,
                  size: 48,
                  color: AppColors.onSurfaceVariant,
                ),
                const SizedBox(height: 16),
                Text(
                  'Nenhum modelo cadastrado na biblioteca.',
                  style: AppTextStyle.bodyMd.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: models.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final uiState = models[index];
              final isCurrentActive =
                  activeModelIds.contains(uiState.modelInfo.id);
              return AiModelCard(
                uiState: uiState,
                isActiveRuntime: isCurrentActive && uiState.isDownloaded,
              );
            },
          ),
      ],
    );
  }
}
