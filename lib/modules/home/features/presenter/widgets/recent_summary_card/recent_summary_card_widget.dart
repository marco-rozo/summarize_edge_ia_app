import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/core/theme/styles/text_styles.dart';
import 'package:summary_app/modules/home/features/domain/entities/recent_summary_entity.dart';

class RecentSummaryCardWidget extends StatefulWidget {
  const RecentSummaryCardWidget({
    super.key,
    required this.entity,
    this.onTap,
    this.isFirst = false,
  });

  final RecentSummaryEntity entity;
  final VoidCallback? onTap;
  final bool isFirst;

  @override
  State<RecentSummaryCardWidget> createState() =>
      _RecentSummaryCardWidgetState();
}

class _RecentSummaryCardWidgetState extends State<RecentSummaryCardWidget> {
  bool _isHovered = false;

  Color get _typeColor {
    switch (widget.entity.type.toUpperCase()) {
      case 'PDF':
      case 'DOCX':
        return AppColors.tertiary;
      case 'ÁUDIO':
      case 'AUDIO':
        return AppColors.secondary;
      default:
        return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool highlightBorder = widget.isFirst || _isHovered;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: _isHovered ? AppColors.surfaceContainerLow : AppColors.surface,
          border: Border(
            left: BorderSide(
              color: highlightBorder ? AppColors.primary : Colors.transparent,
              width: 4,
            ),
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onTap ?? () {},
            splashColor: AppColors.primary.withValues(alpha: 0.08),
            highlightColor: AppColors.primary.withValues(alpha: 0.04),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Type Tag & Data
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainerHigh,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          widget.entity.type.toUpperCase(),
                          style: AppTextStyle.labelSm.copyWith(
                            color: _typeColor,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        widget.entity.formattedDate,
                        style: AppTextStyle.labelSm.copyWith(
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Esquerda: Informações do Resumo
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Título
                            AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 150),
                              style: AppTextStyle.bodyMd.copyWith(
                                color: _isHovered
                                    ? AppColors.primary
                                    : AppColors.onSurface,
                                fontWeight: FontWeight.w500,
                              ),
                              child: Text(widget.entity.title),
                            ),
                            const SizedBox(height: 4),

                            // Descrição
                            Text(
                              widget.entity.description,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyle.labelSm.copyWith(
                                color: AppColors.onSurfaceVariant.withValues(
                                  alpha: 0.7,
                                ),
                                letterSpacing: 0,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 16),

                      // Direita: Métrica e Botão de Seta
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                widget.entity.metricLabel.toUpperCase(),
                                style: AppTextStyle.labelSm.copyWith(
                                  color: AppColors.onSurfaceVariant,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                widget.entity.metricValue,
                                style: AppTextStyle.labelSm.copyWith(
                                  color: AppColors.onSurface,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 16),

                          // Botão Redondo com Seta
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _isHovered
                                  ? AppColors.surfaceContainerHigh
                                  : AppColors.surfaceContainer,
                            ),
                            child: Icon(
                              Icons.arrow_forward_rounded,
                              size: 20,
                              color: _isHovered
                                  ? AppColors.primary
                                  : AppColors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
