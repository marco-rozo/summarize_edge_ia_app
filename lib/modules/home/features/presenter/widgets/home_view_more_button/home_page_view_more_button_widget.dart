import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/components/summary_app_button/summary_app_button.dart';

class HomePageViewMoreButtonWidget extends StatelessWidget {
  const HomePageViewMoreButtonWidget({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SummaryAppButton.tertiaryBorder(
        width: 180,
        rightIcon: Icons.list_rounded,
        text: 'Ver Mais',
        onPressed: onPressed ?? () {},
      ),
    );
  }
}
