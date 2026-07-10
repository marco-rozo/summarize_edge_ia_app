import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/components/summary_app_button/summary_app_button.dart';

/// Summarize CTA button widget that slides up when audio has been captured.
class SummarizeCtaWidget extends StatelessWidget {
  const SummarizeCtaWidget({
    super.key,
    required this.isVisible,
    required this.onPressed,
  });

  /// Whether the CTA should be visible and interactive.
  final bool isVisible;

  /// Callback triggered when tapping the summarize button.
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
      bottom: isVisible ? 32 : -120,
      left: 24,
      right: 24,
      child: IgnorePointer(
        ignoring: !isVisible,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: isVisible ? 1.0 : 0.0,
          child: SummaryAppButton.primary(
            leftIcon: Icons.auto_awesome_rounded,
            text: 'Resumir com IA',
            onPressed: isVisible ? onPressed : null,
          ),
        ),
      ),
    );
  }
}
