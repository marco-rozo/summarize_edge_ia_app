part of 'onboarding_cubit.dart';

sealed class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object?> get props => [];
}

final class OnboardingPageChanged extends OnboardingState {
  const OnboardingPageChanged({required this.currentPage});

  final int currentPage;

  @override
  List<Object?> get props => [currentPage];
}
