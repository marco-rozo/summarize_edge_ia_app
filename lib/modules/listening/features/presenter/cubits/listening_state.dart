part of 'listening_cubit.dart';

sealed class ListeningState extends Equatable {
  const ListeningState();

  @override
  List<Object?> get props => [];
}

final class ListeningInitial extends ListeningState {
  const ListeningInitial();
}

/// Microphone permission granted — ready to record audio.
final class ListeningReady extends ListeningState {
  const ListeningReady();
}

final class ListeningPermissionDenied extends ListeningState {
  final bool isPermanent;

  const ListeningPermissionDenied({required this.isPermanent});

  @override
  List<Object?> get props => [isPermanent];
}
