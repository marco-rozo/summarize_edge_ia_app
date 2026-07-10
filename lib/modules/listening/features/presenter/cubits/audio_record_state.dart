part of 'audio_record_cubit.dart';

sealed class AudioRecordState extends Equatable {
  const AudioRecordState();

  @override
  List<Object?> get props => [];
}

final class AudioRecordInitial extends AudioRecordState {
  const AudioRecordInitial();
}

final class AudioRecordRecording extends AudioRecordState {
  final Duration elapsed;

  const AudioRecordRecording({required this.elapsed});

  @override
  List<Object?> get props => [elapsed];
}

final class AudioRecordRecordingPaused extends AudioRecordState {
  final Duration elapsed;

  const AudioRecordRecordingPaused({required this.elapsed});

  @override
  List<Object?> get props => [elapsed];
}

final class AudioRecordRecorded extends AudioRecordState {
  final String filePath;
  final Duration totalDuration;

  const AudioRecordRecorded({
    required this.filePath,
    required this.totalDuration,
  });

  @override
  List<Object?> get props => [filePath, totalDuration];
}

final class AudioRecordPlaying extends AudioRecordState {
  final String filePath;
  final Duration position;
  final Duration totalDuration;

  const AudioRecordPlaying({
    required this.filePath,
    required this.position,
    required this.totalDuration,
  });

  @override
  List<Object?> get props => [filePath, position, totalDuration];
}

final class AudioRecordPaused extends AudioRecordState {
  final String filePath;
  final Duration position;
  final Duration totalDuration;

  const AudioRecordPaused({
    required this.filePath,
    required this.position,
    required this.totalDuration,
  });

  @override
  List<Object?> get props => [filePath, position, totalDuration];
}

final class AudioRecordError extends AudioRecordState {
  final Failure failure;

  const AudioRecordError({required this.failure});

  @override
  List<Object?> get props => [failure];
}
