import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/core/theme/styles/text_styles.dart';

/// Exibido quando o histórico de mensagens está vazio.
class ChatEmptyWidget extends StatelessWidget {
  const ChatEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.secondary, AppColors.primaryLight],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.auto_awesome_rounded,
              color: AppColors.white,
              size: 36,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Como posso ajudar?',
            style: AppTextStyle.headline16,
          ),
          const SizedBox(height: 8),
          const Text(
            'Escreva sua mensagem para começar\numa conversa.',
            textAlign: TextAlign.center,
            style: AppTextStyle.chatEmptyState,
          ),
        ],
      ),
    );
  }
}
