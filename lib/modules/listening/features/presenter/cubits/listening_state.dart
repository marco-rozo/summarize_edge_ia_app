part of 'listening_cubit.dart';

sealed class ListeningState extends Equatable {
  const ListeningState();

  @override
  List<Object?> get props => [];
}

final class ListeningInitial extends ListeningState {
  const ListeningInitial();
}

final class ListeningInProgress extends ListeningState {
  final String recognizedText;
  final String fullPreviousText;

  const ListeningInProgress({
    required this.recognizedText,
    this.fullPreviousText = '',
  });

  @override
  List<Object?> get props => [recognizedText, fullPreviousText];
}

final class ListeningPaused extends ListeningState {
  final String recognizedText;

  const ListeningPaused({required this.recognizedText});

  @override
  List<Object?> get props => [recognizedText];
}

final class ListeningPermissionDenied extends ListeningState {
  final bool isPermanent;

  const ListeningPermissionDenied({required this.isPermanent});

  @override
  List<Object?> get props => [isPermanent];
}

final class ListeningError extends ListeningState {
  final Failure failure;

  const ListeningError({required this.failure});

  @override
  List<Object?> get props => [failure];
}
