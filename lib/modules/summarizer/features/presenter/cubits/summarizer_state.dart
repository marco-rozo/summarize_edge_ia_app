// Caminho: summary_app/lib/modules/summarizer/features/presenter/cubits/summarizer_state.dart

part of 'summarizer_cubit.dart';

sealed class SummarizerState extends Equatable {
  const SummarizerState();

  @override
  List<Object?> get props => [];
}

final class SummarizerInitial extends SummarizerState {
  const SummarizerInitial();
}

final class SummarizerLoading extends SummarizerState {
  const SummarizerLoading();
}

final class SummarizerSuccess extends SummarizerState {
  const SummarizerSuccess({required this.transcribedText});

  final String transcribedText;

  @override
  List<Object?> get props => [transcribedText];
}

final class SummarizerError extends SummarizerState {
  const SummarizerError({required this.failure});

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
