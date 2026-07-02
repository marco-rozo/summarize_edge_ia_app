import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:summary_app/modules/onboarding/features/presenter/cubits/onboarding_cubit.dart';
import 'package:summary_app/modules/onboarding/features/presenter/pages/onboarding_page.dart';

final class OnboardingRoutes {
  static const String path = '/onboarding';

  static const int _totalPages = 4;

  static List<GoRoute> get routes => [
    GoRoute(
      path: path,
      builder: (context, state) => BlocProvider<OnboardingCubit>(
        create: (_) => OnboardingCubit(totalPages: _totalPages),
        child: OnboardingPage(
          onCompleted: () => context.go('/'),
          onSkip: () => context.go('/'),
        ),
      ),
    ),
  ];
}
