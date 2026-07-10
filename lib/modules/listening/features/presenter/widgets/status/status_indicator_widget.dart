import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/core/theme/styles/text_styles.dart';

/// Possible visual states for [StatusIndicatorWidget].
enum StatusIndicatorState {
  /// Idle — microphone has not been used yet.
  ready,

  /// Active — currently capturing audio.
  recording,

  /// Done — audio has been captured and is ready to summarize.
  captured,
}

/// A pill-shaped status chip with a colored LED dot and a label.
///
/// Renders according to [status]:
/// - [StatusIndicatorState.ready]     → dim outline-variant dot / "Pronto para gravar"
/// - [StatusIndicatorState.recording] → pulsing purple dot / "Gravando áudio…"
/// - [StatusIndicatorState.captured]  → solid cyan dot / "Áudio capturado"
class StatusIndicatorWidget extends StatefulWidget {
  const StatusIndicatorWidget({
    super.key,
    required this.status,
  });

  final StatusIndicatorState status;

  @override
  State<StatusIndicatorWidget> createState() => _StatusIndicatorWidgetState();
}

class _StatusIndicatorWidgetState extends State<StatusIndicatorWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _pulseAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _syncAnimation();
  }

  @override
  void didUpdateWidget(covariant StatusIndicatorWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.status != widget.status) _syncAnimation();
  }

  void _syncAnimation() {
    if (widget.status == StatusIndicatorState.recording) {
      _pulseController.repeat(reverse: true);
    } else {
      _pulseController.stop();
      _pulseController.value = 1.0;
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Color get _dotColor => switch (widget.status) {
        StatusIndicatorState.ready => AppColors.outlineVariant,
        StatusIndicatorState.recording => AppColors.primary,
        StatusIndicatorState.captured => AppColors.tertiary,
      };

  String get _label => switch (widget.status) {
        StatusIndicatorState.ready => 'Pronto para gravar',
        StatusIndicatorState.recording => 'Gravando áudio...',
        StatusIndicatorState.captured => 'Áudio capturado',
      };

  Color get _labelColor => switch (widget.status) {
        StatusIndicatorState.ready => AppColors.onSurfaceVariant,
        StatusIndicatorState.recording => AppColors.primary,
        StatusIndicatorState.captured => AppColors.tertiary,
      };

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(99),
        border: Border.all(
          color: AppColors.white.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (_, _) => Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _dotColor.withValues(alpha: _pulseAnimation.value),
              ),
            ),
          ),
          const SizedBox(width: 8),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            style: AppTextStyle.labelSm.copyWith(
              color: _labelColor,
            ),
            child: Text(_label.toUpperCase()),
          ),
        ],
      ),
    );
  }
}
