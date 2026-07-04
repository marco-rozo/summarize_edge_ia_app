import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/modules/ai_models/features/presenter/widgets/ai_models_loading/ai_models_shimmer_skeletons.dart';

class AiModelLoadingBodyWidget extends StatelessWidget {
  const AiModelLoadingBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Shimmer.fromColors(
            baseColor: AppColors.surfaceContainerLow,
            highlightColor: AppColors.surfaceContainerHigh,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ShimmerHeaderSkeleton(),
                const SizedBox(height: 40),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isDesktop = constraints.maxWidth >= 900;
                    if (isDesktop) {
                      return const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 4, child: ShimmerRuntimeSkeleton()),
                          SizedBox(width: 24),
                          Expanded(flex: 7, child: ShimmerLibrarySkeleton()),
                        ],
                      );
                    } else {
                      return const Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ShimmerRuntimeSkeleton(),
                          SizedBox(height: 32),
                          ShimmerLibrarySkeleton(),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
