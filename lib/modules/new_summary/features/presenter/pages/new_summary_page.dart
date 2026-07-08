import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/core/theme/components/summary_app_background/summary_app_background.dart';
import 'package:summary_app/core/theme/styles/text_styles.dart';

class NewSummaryPage extends StatelessWidget {
  const NewSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundBase,
      body: SummaryAppBackground(
        child: Center(
          child: Text(
            'New Summary',
            style: AppTextStyle.headlineMd.copyWith(
              color: AppColors.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}
