import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/core/theme/components/summary_app_button/summary_app_button.dart';
import 'package:summary_app/core/theme/styles/text_styles.dart';
import 'package:summary_app/modules/ai_models/features/presenter/cubits/ai_models_cubit.dart';

class AiModelStatusAndActions extends StatelessWidget {
  final AiModelUIState uiState;
  final bool isActiveRuntime;
  final bool isWide;

  const AiModelStatusAndActions({
    super.key,
    required this.uiState,
    required this.isActiveRuntime,
    required this.isWide,
  });

  void _confirmDelete(
    BuildContext context,
    AiModelsCubit cubit,
    AiModelUIState state,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text(
          'Remover modelo?',
          style: AppTextStyle.headlineMd.copyWith(color: AppColors.onSurface),
        ),
        content: Text(
          'Deseja apagar o arquivo do modelo "${state.modelInfo.name}" do dispositivo?',
          style: AppTextStyle.bodyMd.copyWith(
            color: AppColors.onSurfaceVariant,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(
              'Cancelar',
              style: AppTextStyle.labelMd.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.negative,
            ),
            onPressed: () {
              Navigator.of(ctx).pop();
              cubit.deleteModel(state);
            },
            child: Text(
              'Remover',
              style: AppTextStyle.labelMd.copyWith(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AiModelsCubit>();
    if (uiState.isDownloaded) {
      return Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 12,
        runSpacing: 10,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.tertiary,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.tertiary.withValues(alpha: 0.5),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              Text(
                'Pronto',
                style: AppTextStyle.labelSm.copyWith(color: AppColors.tertiary),
              ),
            ],
          ),
          if (isActiveRuntime)
            SummaryAppButton.secondary(
              text: 'Carregado'.toUpperCase(),
              width: 120,
              onPressed: null,
            )
          else
            SummaryAppButton.secondary(
              text: 'Carregar Modelo'.toUpperCase(),
              width: 168,
              onPressed: () => cubit.selectModel(uiState.modelInfo.id),
            ),
          IconButton(
            icon: const Icon(
              Icons.delete_outline_rounded,
              color: AppColors.negative,
              size: 20,
            ),
            tooltip: 'Deletar arquivo local',
            onPressed: () => _confirmDelete(context, cubit, uiState),
          ),
        ],
      );
    } else {
      return SummaryAppButton.primary(
        text: 'Baixar'.toUpperCase(),
        leftIcon: Icons.download_rounded,
        width: isWide ? 180 : double.infinity,
        onPressed: () => cubit.downloadModel(uiState),
      );
    }
  }
}
