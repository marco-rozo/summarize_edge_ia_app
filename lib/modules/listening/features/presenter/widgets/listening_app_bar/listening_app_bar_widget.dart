import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/core/theme/components/summary_app_bar/summary_app_bar.dart';
import 'package:summary_app/core/theme/styles/text_styles.dart';

/// App bar specifically tailored for [ListeningPage].
///
/// Displays the title with an Edge AI Summary icon and an optional clear action button.
class ListeningAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const ListeningAppBarWidget({
    super.key,
    required this.showClearButton,
    required this.onClearPressed,
  });

  /// Whether the clear/refresh action button should be visible.
  final bool showClearButton;

  /// Callback triggered when the clear/refresh button is pressed.
  final VoidCallback onClearPressed;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1.0);

  @override
  Widget build(BuildContext context) {
    return SummaryAppBar(
      showBackButton: false,
      titleWidget: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 10),
          const Icon(
            Icons.memory_rounded,
            color: AppColors.primary,
            size: 22,
          ),
          const SizedBox(width: 8),
          Text(
            'Edge AI Summary',
            style: AppTextStyle.headlineMd.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actions: [
        if (showClearButton)
          IconButton(
            icon: const Icon(
              Icons.refresh_rounded,
              color: AppColors.onSurfaceVariant,
            ),
            tooltip: 'Limpar',
            onPressed: onClearPressed,
          ),
      ],
    );
  }
}
