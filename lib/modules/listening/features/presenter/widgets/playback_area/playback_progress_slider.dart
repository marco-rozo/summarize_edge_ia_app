import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/core/theme/styles/text_styles.dart';

class PlaybackProgressSlider extends StatelessWidget {
  const PlaybackProgressSlider({
    super.key,
    required this.position,
    required this.totalDuration,
    required this.onSeek,
  });

  final Duration position;
  final Duration totalDuration;
  final ValueChanged<Duration> onSeek;

  @override
  Widget build(BuildContext context) {
    final double maxSeconds =
        totalDuration.inMilliseconds > 0
            ? totalDuration.inMilliseconds / 1000
            : 1.0;
    final double currentSeconds =
        (position.inMilliseconds / 1000).clamp(0.0, maxSeconds);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: AppColors.primary,
            inactiveTrackColor: AppColors.borderLight,
            thumbColor: AppColors.primary,
            overlayColor: AppColors.primary.withValues(alpha: 0.16),
            trackHeight: 4,
            thumbShape: const RoundSliderThumbShape(
              enabledThumbRadius: 6,
            ),
          ),
          child: Slider(
            value: currentSeconds,
            max: maxSeconds,
            onChanged: (value) {
              onSeek(
                Duration(milliseconds: (value * 1000).round()),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatDuration(position),
                style: AppTextStyle.body12.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
              ),
              Text(
                _formatDuration(totalDuration),
                style: AppTextStyle.body12.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    final int minutes = duration.inMinutes;
    final int seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
