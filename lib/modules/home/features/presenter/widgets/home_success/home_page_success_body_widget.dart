import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/core/theme/styles/text_styles.dart';
import 'package:summary_app/modules/home/features/domain/entities/recent_summary_entity.dart';
import 'package:summary_app/modules/home/features/presenter/widgets/recent_summary_card/recent_summary_card_widget.dart';

class HomePageSuccessBodyWidget extends StatelessWidget {
  const HomePageSuccessBodyWidget({super.key, required this.summaries});

  final List<RecentSummaryEntity> summaries;

  @override
  Widget build(BuildContext context) {
    if (summaries.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 48),
        child: Center(
          child: Text(
            'Nenhum resumo encontrado.',
            style: AppTextStyle.bodyMd.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: summaries.length,
      separatorBuilder: (context, index) => const Divider(
        height: 1,
        thickness: 1,
        color: AppColors.surfaceBorder,
      ),
      itemBuilder: (context, index) {
        final summary = summaries[index];
        return RecentSummaryCardWidget(
          entity: summary,
          isFirst: index == 0,
          onTap: () {},
        );
      },
    );
  }
}
