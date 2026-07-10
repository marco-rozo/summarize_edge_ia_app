import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/styles/text_styles.dart';
import 'package:summary_app/modules/listening/features/presenter/widgets/status/status_indicator_widget.dart';

/// Status chip + elapsed timer stacked vertically.
class StatusSectionWidget extends StatelessWidget {
  const StatusSectionWidget({
    super.key,
    required this.indicatorStatus,
    required this.timerLabel,
    required this.showTimer,
  });

  /// Current status to display on the indicator chip.
  final StatusIndicatorState indicatorStatus;

  /// Formatted timer string (e.g., '01:23').
  final String timerLabel;

  /// Whether to display the elapsed recording timer.
  final bool showTimer;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        StatusIndicatorWidget(status: indicatorStatus),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: showTimer
              ? Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: showTimer ? 1.0 : 0.0,
                    child: Text(
                      timerLabel,
                      style: AppTextStyle.headlineLgMobile.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.6,
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
