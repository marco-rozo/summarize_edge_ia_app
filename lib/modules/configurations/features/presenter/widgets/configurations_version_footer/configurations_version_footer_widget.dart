import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/core/theme/styles/text_styles.dart';

class ConfigurationsVersionFooterWidget extends StatelessWidget {
  const ConfigurationsVersionFooterWidget({
    super.key,
    required this.appVersion,
  });

  final String appVersion;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Text(
          appVersion,
          textAlign: TextAlign.center,
          style: AppTextStyle.labelSm.copyWith(
            color: AppColors.onSurfaceVariant.withValues(alpha: 0.5),
            fontSize: 11,
          ),
        ),
      ),
    );
  }
}
