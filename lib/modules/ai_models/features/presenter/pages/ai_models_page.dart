import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/core/theme/components/summary_app_background/summary_app_background.dart';
import 'package:summary_app/core/theme/components/summary_app_bar/summary_app_bar.dart';
import 'package:summary_app/core/theme/components/summary_app_button/summary_app_button.dart';
import 'package:summary_app/core/theme/styles/text_styles.dart';
import 'package:summary_app/modules/ai_models/features/presenter/cubits/ai_models_cubit.dart';
import 'package:summary_app/modules/ai_models/features/presenter/widgets/active_runtime_panel.dart';
import 'package:summary_app/modules/ai_models/features/presenter/widgets/ai_models_header.dart';
import 'package:summary_app/modules/ai_models/features/presenter/widgets/available_library_panel.dart';

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
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.primaryLight,
                    ),
                  ),
                );
              }

              if (state is AiModelsError) {
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
                          state.failure.userMessage,
                          style: AppTextStyle.bodyMd.copyWith(
                            color: AppColors.onSurface,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        SummaryAppButton.primary(
                          text: 'Tentar Novamente',
                          leftIcon: Icons.refresh_rounded,
                          width: 220,
                          onPressed: () =>
                              context.read<AiModelsCubit>().fetchModels(),
                        ),
                      ],
                    ),
                  ),
                );
              }

              if (state is AiModelsSuccess) {
                final models = state.models;
                final activeIds = state.activeModelIds.values.toSet();
                final activeModels = models
                    .where((m) => activeIds.contains(m.modelInfo.id))
                    .toList();

                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 32.0,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AiModelsHeader(),
                          const SizedBox(height: 40),
                          LayoutBuilder(
                            builder: (context, constraints) {
                              final isDesktop = constraints.maxWidth >= 900;
                              if (isDesktop) {
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: ActiveRuntimePanel(
                                        activeModels: activeModels,
                                      ),
                                    ),
                                    const SizedBox(width: 24),
                                    Expanded(
                                      flex: 7,
                                      child: AvailableLibraryPanel(
                                        models: models,
                                        activeModelIds: activeIds,
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    ActiveRuntimePanel(
                                      activeModels: activeModels,
                                    ),
                                    const SizedBox(height: 32),
                                    AvailableLibraryPanel(
                                      models: models,
                                      activeModelIds: activeIds,
                                    ),
                                  ],
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
