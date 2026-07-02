import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/modules/onboarding/features/presenter/cubits/onboarding_cubit.dart';
import 'package:summary_app/modules/onboarding/features/presenter/widgets/background/onboarding_background_decoration.dart';
import 'package:summary_app/modules/onboarding/features/presenter/widgets/hero/onboarding_hero_section.dart';
import 'package:summary_app/modules/onboarding/features/presenter/widgets/navigation/onboarding_bottom_actions.dart';
import 'package:summary_app/modules/onboarding/features/presenter/widgets/navigation/onboarding_learn_more_link.dart';
import 'package:summary_app/modules/onboarding/features/presenter/widgets/onboarding_feature_card.dart';
import 'package:summary_app/modules/onboarding/features/presenter/widgets/onboarding_page_indicator.dart';
import 'package:summary_app/modules/onboarding/features/presenter/widgets/onboarding_step_data.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key, required this.onCompleted, this.onSkip});

  final VoidCallback onCompleted;
  final VoidCallback? onSkip;

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  static const List<OnboardingStepData> _steps = [
    OnboardingStepData(
      icon: Icons.wifi_off_rounded,
      iconColor: AppColors.tertiary,
      title: '100% Offline',
      description: 'Funciona em qualquer lugar, sem necessidade de internet.',
    ),
    OnboardingStepData(
      icon: Icons.bolt_rounded,
      iconColor: AppColors.primary,
      title: 'Latência Zero',
      description: 'Respostas instantâneas processadas localmente.',
    ),
    OnboardingStepData(
      icon: Icons.shield_outlined,
      iconColor: AppColors.secondary,
      title: 'Privacidade Total',
      description: 'Seus dados nunca saem do seu dispositivo.',
    ),
    OnboardingStepData(
      icon: Icons.download_rounded,
      iconColor: AppColors.tertiary,
      title: 'Modelos Customizáveis',
      description: 'Escolha e baixe o modelo de IA ideal para sua necessidade.',
    ),
  ];

  late final OnboardingCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<OnboardingCubit>();
    _cubit.initPageController();
  }

  void _handleNext() {
    if (_cubit.isLastPage) {
      widget.onCompleted();
    } else {
      _cubit.nextPage();
    }
  }

  void _handleSkip() => (widget.onSkip ?? widget.onCompleted)();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundBase,
      body: Stack(
        children: [
          const OnboardingBackgroundDecoration(),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final bool isLarge = constraints.maxWidth > 600;
                final double hPad = isLarge ? 48 : 16;

                return BlocBuilder<OnboardingCubit, OnboardingState>(
                  bloc: _cubit,
                  builder: (context, state) {
                    final int currentPage = _cubit.currentPage;
                    final bool isLastPage = _cubit.isLastPage;

                    return Column(
                      children: [
                        const SizedBox(height: 68),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: hPad),
                          child: OnboardingHeroSection(isLarge: isLarge),
                        ),
                        const SizedBox(height: 48),
                        Center(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: isLarge ? 480 : double.infinity,
                              maxHeight: 250,
                            ),
                            child: PageView.builder(
                              controller: _cubit.pageController,
                              onPageChanged: _cubit.onPageChanged,
                              itemCount: _steps.length,
                              itemBuilder: (_, index) => Padding(
                                padding: EdgeInsets.symmetric(horizontal: hPad),
                                child: OnboardingFeatureCard(
                                  data: _steps[index],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Expanded(child: SizedBox.shrink()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: hPad),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 448),
                            child: Column(
                              children: [
                                OnboardingPageIndicator(
                                  count: _steps.length,
                                  currentIndex: currentPage,
                                  onDotTap: _cubit.goToPage,
                                ),
                                const SizedBox(height: 24),
                                OnboardingBottomActions(
                                  isLastPage: isLastPage,
                                  onSkip: _handleSkip,
                                  onNext: _handleNext,
                                  onCompleted: widget.onCompleted,
                                ),
                                const SizedBox(height: 32),
                                OnboardingLearnMoreLink(
                                  onTap: () {
                                    // TODO: implement learn more
                                    Logger().i('Learn More');
                                  },
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
