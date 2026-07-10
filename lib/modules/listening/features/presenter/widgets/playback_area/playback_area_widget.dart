import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/modules/listening/features/presenter/widgets/playback_area/playback_delete_button.dart';
import 'package:summary_app/modules/listening/features/presenter/widgets/playback_area/playback_play_pause_button.dart';
import 'package:summary_app/modules/listening/features/presenter/widgets/playback_area/playback_progress_slider.dart';

class PlaybackAreaWidget extends StatelessWidget {
  const PlaybackAreaWidget({
    super.key,
    required this.isVisible,
    required this.isPlaying,
    required this.position,
    required this.totalDuration,
    required this.onPlayPause,
    required this.onSeek,
    required this.onDelete,
  });

  final bool isVisible;
  final bool isPlaying;
  final Duration position;
  final Duration totalDuration;
  final VoidCallback onPlayPause;
  final ValueChanged<Duration> onSeek;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    if (!isVisible) {
      return const SizedBox.shrink();
    }

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: isVisible ? 1.0 : 0.0,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerHigh.withValues(alpha: 0.85),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.white.withValues(alpha: 0.08),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                PlaybackPlayPauseButton(
                  isPlaying: isPlaying,
                  onPlayPause: onPlayPause,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: PlaybackProgressSlider(
                    position: position,
                    totalDuration: totalDuration,
                    onSeek: onSeek,
                  ),
                ),
                const SizedBox(width: 8),
                PlaybackDeleteButton(
                  onDelete: onDelete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
