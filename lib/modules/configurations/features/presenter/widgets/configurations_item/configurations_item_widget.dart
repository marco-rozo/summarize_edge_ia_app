import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/core/theme/styles/text_styles.dart';

/// Represents a single tappable configuration item in the configurations list.
class ConfigurationItemEntity {
  const ConfigurationItemEntity({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.borderRadius = 8.0,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final double borderRadius;
}

/// A single settings row with leading icon, title, subtitle and trailing arrow.
class ConfigurationsItemWidget extends StatelessWidget {
  const ConfigurationsItemWidget({super.key, required this.item});

  final ConfigurationItemEntity item;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(item.borderRadius);

    return Material(
      color: AppColors.surfaceContainer,
      borderRadius: borderRadius,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: item.onTap,
        splashColor: AppColors.primary.withValues(alpha: 0.08),
        highlightColor: AppColors.primary.withValues(alpha: 0.04),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              // Leading icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(item.icon, size: 20, color: AppColors.primary),
              ),
              const SizedBox(width: 16),

              // Title + Subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: AppTextStyle.bodyMd.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.subtitle,
                      style: AppTextStyle.labelSm.copyWith(
                        color: AppColors.onSurfaceVariant,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),

              // Trailing arrow
              const Icon(
                Icons.chevron_right_rounded,
                size: 20,
                color: AppColors.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
