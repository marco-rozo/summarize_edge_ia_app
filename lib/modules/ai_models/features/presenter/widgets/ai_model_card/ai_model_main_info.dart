import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/core/theme/components/summary_app_meta_chip/summary_app_meta_chip.dart';
import 'package:summary_app/core/theme/styles/text_styles.dart';
import 'package:summary_app/modules/ai_models/features/domain/entities/ai_model_entity.dart';

class AiModelMainInfo extends StatelessWidget {
  final AiModelEntity model;
  final bool isOffline;
  final bool isDownloading;
  final bool isActiveRuntime;

  const AiModelMainInfo({
    super.key,
    required this.model,
    required this.isOffline,
    required this.isDownloading,
    required this.isActiveRuntime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                model.name,
                style: AppTextStyle.headlineMd.copyWith(
                  color: AppColors.onSurface,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (isActiveRuntime) ...[
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'EM USO',
                  style: AppTextStyle.labelSm.copyWith(
                    color: AppColors.primary,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 6),
        Text(
          model.description,
          style: AppTextStyle.bodyMd.copyWith(
            color: AppColors.onSurfaceVariant,
            fontSize: 14,
            height: 1.4,
          ),
        ),
        if (!isDownloading) ...[
          const SizedBox(height: 14),
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: [
              SummaryAppMetaChip(
                icon: isOffline ? Icons.cloud_outlined : Icons.sd_card,
                text: model.formattedSize,
              ),
              SummaryAppMetaChip(
                icon: Icons.speed_rounded,
                text: model.taskTypeLabel,
              ),
            ],
          ),
        ],
      ],
    );
  }
}
