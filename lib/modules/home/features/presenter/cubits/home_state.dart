part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

final class HomeInitial extends HomeState {
  const HomeInitial();
}

final class HomeLoading extends HomeState {
  const HomeLoading();
}

final class HomeSuccess extends HomeState {
  final List<RecentSummaryEntity> summaries;

  const HomeSuccess({required this.summaries});

  @override
  List<Object?> get props => [summaries];
}

final class HomeError extends HomeState {
  final Failure failure;

  const HomeError({required this.failure});

  @override
  List<Object?> get props => [failure];
}
