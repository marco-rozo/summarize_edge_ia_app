import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/core/theme/components/summary_app_button/summary_app_button.dart';
import 'package:summary_app/core/theme/styles/text_styles.dart';
import 'package:summary_app/modules/ai_models/features/presenter/cubits/ai_models_cubit.dart';

class AiModelErrorBodyWidget extends StatelessWidget {
  final String errorMessage;
  final VoidCallback? onRetry;

  const AiModelErrorBodyWidget({
    super.key,
    required this.errorMessage,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              size: 64,
              color: AppColors.negative,
            ),
            const SizedBox(height: 16),
            Text(
              errorMessage,
              style: AppTextStyle.bodyMd.copyWith(color: AppColors.onSurface),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SummaryAppButton.primary(
              text: 'Tentar Novamente',
              leftIcon: Icons.refresh_rounded,
              width: 220,
              onPressed:
                  onRetry ?? () => context.read<AiModelsCubit>().fetchModels(),
            ),
          ],
        ),
      ),
    );
  }
}
