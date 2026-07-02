import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';

class FeatureCardIcon extends StatelessWidget {
  const FeatureCardIcon({
    super.key,
    required this.icon,
    required this.color,
  });

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.surfaceBorder,
          width: 1,
        ),
      ),
      child: Icon(
        icon,
        color: color,
        size: 28,
      ),
    );
  }
}
