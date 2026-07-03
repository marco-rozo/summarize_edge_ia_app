import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/core/theme/styles/text_styles.dart';

class SummaryAppMetaChip extends StatelessWidget {
  const SummaryAppMetaChip({
    super.key,
    required this.icon,
    required this.text,
    this.iconColor = AppColors.outline,
    this.textColor = AppColors.outline,
  });

  final IconData icon;
  final String text;
  final Color iconColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: iconColor),
        const SizedBox(width: 4),
        Text(
          text,
          style: AppTextStyle.labelSm.copyWith(
            color: textColor,
            fontWeight: FontWeight.w500,
            letterSpacing: 0,
          ),
        ),
      ],
    );
  }
}
