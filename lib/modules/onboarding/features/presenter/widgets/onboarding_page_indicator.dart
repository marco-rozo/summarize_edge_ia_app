import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';

class OnboardingPageIndicator extends StatelessWidget {
  const OnboardingPageIndicator({
    super.key,
    required this.count,
    required this.currentIndex,
    this.onDotTap,
  });

  final int count;
  final int currentIndex;
  final ValueChanged<int>? onDotTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (index) {
        final bool isActive = index == currentIndex;
        return GestureDetector(
          onTap: onDotTap != null ? () => onDotTap!(index) : null,
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.primary
                    : AppColors.surfaceContainerHighest,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      }),
    );
  }
}
