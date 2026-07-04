import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/modules/home/features/presenter/cubits/home_cubit.dart';
import 'package:summary_app/modules/home/features/presenter/widgets/home_error/home_page_error_body_widget.dart';
import 'package:summary_app/modules/home/features/presenter/widgets/home_loading/home_page_loading_body_widget.dart';
import 'package:summary_app/modules/home/features/presenter/widgets/home_success/home_page_success_body_widget.dart';

class HomePageSummariesPanelWidget extends StatelessWidget {
  const HomePageSummariesPanelWidget({super.key, required this.cubit});

  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.04),
        border: Border.all(color: AppColors.surfaceBorder, width: 1),
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: BlocBuilder<HomeCubit, HomeState>(
        bloc: cubit,
        builder: (context, state) {
          if (state is HomeLoading || state is HomeInitial) {
            return const HomePageLoadingBodyWidget();
          }

          if (state is HomeError) {
            return HomePageErrorBodyWidget(
              onRetry: () => cubit.init(),
            );
          }

          if (state is HomeSuccess) {
            return HomePageSuccessBodyWidget(summaries: state.summaries);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
