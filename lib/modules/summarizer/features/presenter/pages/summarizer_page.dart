// Caminho: summary_app/lib/modules/summarizer/features/presenter/pages/summarizer_page.dart

import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/core/theme/styles/text_styles.dart';

/// Tela que exibe centralizado o nome do áudio salvo para sumarização.
class SummarizerPage extends StatelessWidget {
  const SummarizerPage({
    super.key,
    required this.audioFilePath,
  });

  final String audioFilePath;

  String get _fileName {
    final parts = audioFilePath.split('/');
    return parts.isNotEmpty ? parts.last : audioFilePath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundBase,
      appBar: AppBar(
        title: Text(
          'Resumo de Áudio',
          style: AppTextStyle.headlineMd.copyWith(color: AppColors.onSurface),
        ),
        backgroundColor: AppColors.surfaceContainerLow,
        iconTheme: const IconThemeData(color: AppColors.onSurface),
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.audio_file_rounded,
                  color: AppColors.primary,
                  size: 44,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Áudio Pronto para Resumo',
                style: AppTextStyle.headline16.copyWith(
                  color: AppColors.onSurface,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'Arquivo salvo selecionado:',
                style: AppTextStyle.bodyMd.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainer,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.surfaceBorder),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.graphic_eq_rounded,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        _fileName,
                        style: AppTextStyle.bodyLg.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
