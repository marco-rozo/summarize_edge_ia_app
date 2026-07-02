import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/components/my_app_button/my_app_button.dart';
import 'package:summary_app/core/theme/components/my_app_text_button/my_app_text_button.dart';

class OnboardingBottomActions extends StatelessWidget {
  const OnboardingBottomActions({
    super.key,
    required this.isLastPage,
    required this.onSkip,
    required this.onNext,
    required this.onCompleted,
  });

  final bool isLastPage;
  final VoidCallback onSkip;
  final VoidCallback onNext;
  final VoidCallback onCompleted;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: isLastPage ? 0.0 : 1.0,
            child: IgnorePointer(
              ignoring: isLastPage,
              child: _buildNavigationRow(),
            ),
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: isLastPage ? 1.0 : 0.0,
            child: AnimatedScale(
              duration: const Duration(milliseconds: 200),
              scale: isLastPage ? 1.0 : 0.95,
              child: IgnorePointer(
                ignoring: !isLastPage,
                child: _buildFinishButton(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyAppTextButton(text: 'Pular', onPressed: onSkip),
        SizedBox(
          width: 145,
          child: MyAppButton.tertiary(
            text: 'Próximo',
            onPressed: onNext,
            rightIcon: Icons.arrow_forward_rounded,
          ),
        ),
      ],
    );
  }

  Widget _buildFinishButton() {
    return MyAppButton.primary(
      text: 'Começar agora',
      onPressed: onCompleted,
      rightIcon: Icons.arrow_forward_rounded,
    );
  }
}
