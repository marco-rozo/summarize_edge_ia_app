import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';

class PlaybackDeleteButton extends StatelessWidget {
  const PlaybackDeleteButton({
    super.key,
    required this.onDelete,
  });

  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onDelete,
      icon: const Icon(
        Icons.delete_outline,
        color: AppColors.negative,
      ),
      tooltip: 'Excluir gravação',
    );
  }
}
