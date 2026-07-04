import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/core/theme/styles/text_styles.dart';

class HomePageSectionHeaderWidget extends StatelessWidget {
  const HomePageSectionHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Últimos Resumos',
              style: AppTextStyle.headlineMd.copyWith(
                color: AppColors.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'PROCESSADOS LOCALMENTE',
              style: AppTextStyle.labelSm.copyWith(
                color: AppColors.onSurfaceVariant,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Icon(
              Icons.storage_rounded,
              size: 16,
              color: AppColors.onSurfaceVariant,
            ),
            const SizedBox(width: 6),
            Text(
              '14 MB Usados',
              style: AppTextStyle.labelSm.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
