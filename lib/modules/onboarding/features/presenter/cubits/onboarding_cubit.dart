import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit({required this.totalPages})
    : super(const OnboardingPageChanged(currentPage: 0));

  final int totalPages;
  late PageController pageController;

  int get currentPage => state is OnboardingPageChanged
      ? (state as OnboardingPageChanged).currentPage
      : 0;

  bool get isLastPage => currentPage == totalPages - 1;

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }

  void initPageController() {
    pageController = PageController(initialPage: currentPage);
  }

  void onPageChanged(int page) {
    emit(OnboardingPageChanged(currentPage: page));
  }

  void nextPage() {
    if (isLastPage) return;
    pageController.nextPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  void goToPage(int page) {
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }
}
