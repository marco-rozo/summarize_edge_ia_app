import 'package:flutter/material.dart';
import 'package:summary_app/modules/ai_models/features/presenter/cubits/ai_models_cubit.dart';
import 'package:summary_app/modules/ai_models/features/presenter/widgets/active_runtime/active_runtime_panel.dart';
import 'package:summary_app/modules/ai_models/features/presenter/widgets/ai_models_header/ai_models_header.dart';
import 'package:summary_app/modules/ai_models/features/presenter/widgets/available_library/available_library_panel.dart';

class AiModelSuccessBodyWidget extends StatelessWidget {
  final AiModelsSuccess state;

  const AiModelSuccessBodyWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final models = state.models;
    final activeIds = state.activeModelIds.values.toSet();
    final activeModels = models
        .where((m) => activeIds.contains(m.modelInfo.id))
        .toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
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
                          child: ActiveRuntimePanel(activeModels: activeModels),
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
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ActiveRuntimePanel(activeModels: activeModels),
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
}
