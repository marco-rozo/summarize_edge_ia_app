import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';

class PlaybackPlayPauseButton extends StatelessWidget {
  const PlaybackPlayPauseButton({
    super.key,
    required this.isPlaying,
    required this.onPlayPause,
  });

  final bool isPlaying;
  final VoidCallback onPlayPause;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: isPlaying ? 'Pausar' : 'Reproduzir',
      child: GestureDetector(
        onTap: onPlayPause,
        child: Container(
          width: 44,
          height: 44,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          child: Icon(
            isPlaying ? Icons.pause : Icons.play_arrow,
            color: AppColors.black,
            size: 24,
          ),
        ),
      ),
    );
  }
}
