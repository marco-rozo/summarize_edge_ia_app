import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';

class HomePageLoadingBodyWidget extends StatelessWidget {
  const HomePageLoadingBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 60),
      child: Center(
        child: CircularProgressIndicator(
          color: AppColors.primary,
          strokeWidth: 2,
        ),
      ),
    );
  }
}
