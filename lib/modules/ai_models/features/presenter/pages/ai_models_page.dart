import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/core/theme/components/summary_app_background/summary_app_background.dart';
import 'package:summary_app/core/theme/components/summary_app_bar/summary_app_bar.dart';
import 'package:summary_app/modules/ai_models/features/presenter/cubits/ai_models_cubit.dart';
import 'package:summary_app/modules/ai_models/features/presenter/widgets/ai_models_error/ai_model_error_body_widget.dart';
import 'package:summary_app/modules/ai_models/features/presenter/widgets/ai_models_loading/ai_model_loading_body_widget.dart';
import 'package:summary_app/modules/ai_models/features/presenter/widgets/ai_models_success/ai_model_success_body_widget.dart';

class AiModelsPage extends StatelessWidget {
  const AiModelsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundBase,
      extendBodyBehindAppBar: true,
      appBar: SummaryAppBar(
        title: 'Configurações',
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded, color: AppColors.onSurface),
            tooltip: 'Atualizar modelos',
            onPressed: () => context.read<AiModelsCubit>().fetchModels(),
          ),
        ],
      ),
      body: SummaryAppBackground(
        child: SafeArea(
          child: BlocBuilder<AiModelsCubit, AiModelsState>(
            builder: (context, state) {
              if (state is AiModelsLoading || state is AiModelsInitial) {
                return const AiModelLoadingBodyWidget();
              }

              if (state is AiModelsError) {
                return AiModelErrorBodyWidget(
                  errorMessage: state.failure.userMessage,
                  onRetry: () => context.read<AiModelsCubit>().fetchModels(),
                );
              }

              if (state is AiModelsSuccess) {
                return AiModelSuccessBodyWidget(state: state);
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
