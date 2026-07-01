import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/core/theme/styles/text_styles.dart';

class RecognizedTextWidget extends StatelessWidget {
  final String text;
  final ScrollController scrollController;

  const RecognizedTextWidget({
    super.key,
    required this.text,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    if (text.isEmpty) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.mic_none_rounded,
              size: 48,
              color: AppColors.textLightTertiary,
            ),
            SizedBox(height: 12),
            Text(
              'Toque no botão para começar a gravar',
              style: AppTextStyle.body14Secondary,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });

    return SingleChildScrollView(
      controller: scrollController,
      padding: const EdgeInsets.all(20),
      child: Text(
        text,
        style: AppTextStyle.body14Primary,
      ),
    );
  }
}
