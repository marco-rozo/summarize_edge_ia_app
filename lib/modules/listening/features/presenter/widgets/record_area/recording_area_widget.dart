import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/core/theme/components/summary_app_pulse_button/summary_app_pulse_button.dart';
import 'package:summary_app/modules/listening/features/presenter/widgets/record_area/waveform_widget.dart';

/// Circular recording area that layers the waveform behind the pulse button.
class RecordingAreaWidget extends StatelessWidget {
  const RecordingAreaWidget({
    super.key,
    required this.isListening,
    required this.isPaused,
    required this.onTap,
    required this.onStop,
  });

  /// Whether active recording is in progress.
  final bool isListening;

  /// Whether recording is currently paused.
  final bool isPaused;

  /// Callback triggered when tapping the main pulse button.
  final VoidCallback onTap;

  /// Callback triggered when tapping the stop button.
  final VoidCallback onStop;

  bool get _isActiveSession => isListening || isPaused;

  IconData get _pulseIcon {
    if (isListening) return Icons.pause_rounded;
    return Icons.mic_rounded;
  }

  @override
  Widget build(BuildContext context) {
    final double areaSize = MediaQuery.sizeOf(context).width * 0.72;
    final double stopButtonSize = areaSize * 0.18;

    return SizedBox(
      width: areaSize,
      height: areaSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Waveform (behind button)
          WaveformWidget(isActive: isListening),

          // Glassy ring (always visible, subtly highlights when recording)
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            width: areaSize * 0.58,
            height: areaSize * 0.58,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: _isActiveSession
                    ? AppColors.primary.withValues(alpha: 0.18)
                    : AppColors.white.withValues(alpha: 0.04),
                width: 1,
              ),
              boxShadow: _isActiveSession
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.20),
                        blurRadius: 40,
                        spreadRadius: 4,
                      ),
                    ]
                  : [],
            ),
          ),

          // Pulse button (foreground)
          SummaryAppPulseButton(
            icon: _pulseIcon,
            isActive: isListening,
            onPressed: onTap,
            sizeRatio: 0.38,
          ),

          // Stop button (diagonal bottom-right, visible when recording or paused)
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            bottom: _isActiveSession ? areaSize * 0.12 : areaSize * 0.22,
            right: _isActiveSession ? areaSize * 0.08 : areaSize * 0.22,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 250),
              opacity: _isActiveSession ? 1.0 : 0.0,
              child: IgnorePointer(
                ignoring: !_isActiveSession,
                child: Tooltip(
                  message: 'Parar gravação',
                  child: GestureDetector(
                    onTap: onStop,
                    child: Container(
                      width: stopButtonSize,
                      height: stopButtonSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.negative,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.negative.withValues(alpha: 0.40),
                            blurRadius: 12,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.stop_rounded,
                        color: AppColors.white,
                        size: stopButtonSize * 0.6,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
