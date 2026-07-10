import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/components/summary_app_background/summary_app_background.dart';
import 'package:summary_app/modules/listening/features/presenter/widgets/playback_area/playback_area_widget.dart';
import 'package:summary_app/modules/listening/features/presenter/widgets/record_area/recording_area_widget.dart';
import 'package:summary_app/modules/listening/features/presenter/widgets/status/status_indicator_widget.dart';
import 'package:summary_app/modules/listening/features/presenter/widgets/status/status_section_widget.dart';
import 'package:summary_app/modules/listening/features/presenter/widgets/summarize_cta/summarize_cta_widget.dart';

/// Body content of the [ListeningPage] wrapped in a [SummaryAppBackground].
///
/// Composes the status section, recording area, playback area, and summarize CTA.
class ListeningBodyWidget extends StatelessWidget {
  const ListeningBodyWidget({
    super.key,
    required this.indicatorStatus,
    required this.timerLabel,
    required this.showTimer,
    required this.isRecording,
    required this.isPaused,
    required this.hasRecordedAudio,
    required this.isPlaying,
    required this.currentPosition,
    required this.totalDuration,
    required this.onPulseTap,
    required this.onStopRecording,
    required this.onPlayPause,
    required this.onSeek,
    required this.onDeleteRecording,
    required this.onSummarize,
  });

  /// Current status to display on the indicator chip.
  final StatusIndicatorState indicatorStatus;

  /// Formatted elapsed recording timer string.
  final String timerLabel;

  /// Whether the recording timer should be displayed.
  final bool showTimer;

  /// Whether recording is actively occurring.
  final bool isRecording;

  /// Whether recording is currently paused.
  final bool isPaused;

  /// Whether an audio recording has been captured and is ready for playback/summary.
  final bool hasRecordedAudio;

  /// Whether recorded audio is currently playing.
  final bool isPlaying;

  /// Current playback position.
  final Duration currentPosition;

  /// Total duration of the recorded audio.
  final Duration totalDuration;

  /// Callback when the central pulse button is tapped.
  final VoidCallback onPulseTap;

  /// Callback when the stop recording button is tapped.
  final VoidCallback onStopRecording;

  /// Callback when play/pause is toggled on playback.
  final VoidCallback onPlayPause;

  /// Callback when seeking to a new position during playback.
  final ValueChanged<Duration> onSeek;

  /// Callback when deleting the current audio recording.
  final VoidCallback onDeleteRecording;

  /// Callback when tapping the summarize CTA.
  final VoidCallback onSummarize;

  @override
  Widget build(BuildContext context) {
    return SummaryAppBackground(
      child: SafeArea(
        top: false,
        child: Stack(
          children: [
            // Main centered content
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  StatusSectionWidget(
                    indicatorStatus: indicatorStatus,
                    timerLabel: timerLabel,
                    showTimer: showTimer,
                  ),
                  const SizedBox(height: 24),
                  RecordingAreaWidget(
                    isListening: isRecording,
                    isPaused: isPaused,
                    onTap: onPulseTap,
                    onStop: onStopRecording,
                  ),
                  PlaybackAreaWidget(
                    isVisible: hasRecordedAudio,
                    isPlaying: isPlaying,
                    position: currentPosition,
                    totalDuration: totalDuration,
                    onPlayPause: onPlayPause,
                    onSeek: onSeek,
                    onDelete: onDeleteRecording,
                  ),
                ],
              ),
            ),

            // Summarize CTA (slides up when audio is captured)
            SummarizeCtaWidget(
              isVisible: hasRecordedAudio,
              onPressed: onSummarize,
            ),
          ],
        ),
      ),
    );
  }
}
