import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/core/theme/styles/text_styles.dart';
import 'package:summary_app/modules/ai_models/features/presenter/cubits/ai_models_cubit.dart';

class AiModelsPage extends StatelessWidget {
  const AiModelsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: const Text('Modelos de IA'),
        backgroundColor: AppColors.surface,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded, color: AppColors.onSurface),
            tooltip: 'Atualizar lista de modelos',
            onPressed: () => context.read<AiModelsCubit>().fetchModels(),
          ),
        ],
      ),
      body: BlocBuilder<AiModelsCubit, AiModelsState>(
        builder: (context, state) {
          if (state is AiModelsLoading || state is AiModelsInitial) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.primaryLight,
                ),
              ),
            );
          }

          if (state is AiModelsError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline_rounded,
                      size: 64,
                      color: AppColors.negative,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.failure.userMessage,
                      style: AppTextStyle.bodyMd.copyWith(
                        color: AppColors.onSurface,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.primaryLight,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      onPressed: () =>
                          context.read<AiModelsCubit>().fetchModels(),
                      icon: const Icon(Icons.refresh_rounded),
                      label: const Text('Tentar Novamente'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is AiModelsSuccess) {
            final models = state.models;

            if (models.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.folder_open_rounded,
                      size: 64,
                      color: AppColors.onSurfaceVariant,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Nenhum modelo de IA encontrado no Firestore.',
                      style: AppTextStyle.bodyMd.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(16.0),
              itemCount: models.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final uiState = models[index];
                return _AiModelCard(uiState: uiState);
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _AiModelCard extends StatelessWidget {
  final AiModelUIState uiState;

  const _AiModelCard({required this.uiState});

  String _formatSize(int bytes) {
    if (bytes <= 0) return '0.0 MB';
    final mb = bytes / (1024 * 1024);
    return '${mb.toStringAsFixed(1)} MB';
  }

  String _formatTaskType(String taskType) {
    if (taskType.toLowerCase().contains('audio') ||
        taskType.toLowerCase() == 'asr') {
      return 'ASR';
    } else if (taskType.toLowerCase().contains('text')) {
      return 'Text / LLM';
    }
    return taskType.toUpperCase();
  }

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
          'Deseja apagar o arquivo do modelo "${state.modelInfo.name}" do dispositivo? Você precisará baixá-lo novamente para utilizá-lo.',
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
              style: AppTextStyle.labelMd.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, AiModelUIState state) {
    final cubit = context.read<AiModelsCubit>();

    if (state.isDownloaded) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.check_circle_rounded,
            color: AppColors.positive,
            size: 28,
          ),
          const SizedBox(width: 4),
          IconButton(
            icon: const Icon(
              Icons.delete_outline_rounded,
              color: AppColors.negative,
            ),
            tooltip: 'Deletar modelo do dispositivo',
            onPressed: () => _confirmDelete(context, cubit, state),
          ),
        ],
      );
    } else if (state.downloadProgress > 0.0 && state.downloadProgress < 1.0) {
      final percent = (state.downloadProgress * 100).toInt();
      return Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 44,
            height: 44,
            child: CircularProgressIndicator(
              value: state.downloadProgress,
              strokeWidth: 3.5,
              backgroundColor: AppColors.onSurfaceVariant,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.primaryLight,
              ),
            ),
          ),
          Text(
            '$percent%',
            style: AppTextStyle.labelSm.copyWith(
              color: AppColors.primaryLight,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    } else {
      return IconButton(
        icon: const Icon(
          Icons.cloud_download_rounded,
          color: AppColors.primaryLight,
          size: 30,
        ),
        tooltip: 'Baixar modelo',
        onPressed: () => cubit.downloadModel(state),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final model = uiState.modelInfo;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.onSurfaceVariant.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: uiState.isDownloaded
              ? AppColors.positive.withValues(alpha: 0.5)
              : AppColors.onSurfaceVariant,
          width: 1.5,
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name,
                      style: AppTextStyle.headlineMd.copyWith(
                        color: AppColors.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatSize(model.sizeInBytes),
                      style: AppTextStyle.labelSm.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              _buildActionButton(context, uiState),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            model.description,
            style: AppTextStyle.bodyMd.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _TagWidget(
                label: _formatTaskType(model.taskType),
                icon: Icons.psychology_rounded,
                color: AppColors.primaryLight,
              ),
              const SizedBox(width: 8),
              _TagWidget(
                label: model.parameterCount,
                icon: Icons.memory_rounded,
                color: AppColors.secondary,
              ),
              if (uiState.isDownloaded) ...[
                const SizedBox(width: 8),
                const _TagWidget(
                  label: 'Baixado',
                  icon: Icons.offline_pin_rounded,
                  color: AppColors.positive,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _TagWidget extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;

  const _TagWidget({
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppTextStyle.labelSm.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
