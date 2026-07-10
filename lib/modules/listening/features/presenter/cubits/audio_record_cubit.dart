import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:summary_app/core/errors/failure.dart';
import 'package:summary_app/core/externals/audio_player/audio_player_external.dart';
import 'package:summary_app/core/externals/audio_recorder/audio_recorder_external.dart';

part 'audio_record_state.dart';

class AudioRecordCubit extends Cubit<AudioRecordState> {
  final IAudioRecorderExternal _audioRecorderExternal;
  final IAudioPlayerExternal _audioPlayerExternal;
  final Logger _logger;

  Timer? _recordingTimer;
  StreamSubscription<Duration>? _positionSubscription;
  StreamSubscription<void>? _completeSubscription;

  /// Tracks total elapsed seconds across pause/resume cycles.
  int _totalElapsedSeconds = 0;

  AudioRecordCubit({
    required IAudioRecorderExternal audioRecorderExternal,
    required IAudioPlayerExternal audioPlayerExternal,
    required Logger logger,
  })  : _audioRecorderExternal = audioRecorderExternal,
        _audioPlayerExternal = audioPlayerExternal,
        _logger = logger,
        super(const AudioRecordInitial());

  Future<void> startRecording({String fileName = 'session_audio'}) async {
    try {
      await _stopPlaybackInternal();
      _cancelRecordingTimer();
      _totalElapsedSeconds = 0;

      await _audioRecorderExternal.startRecording(fileName);

      emit(const AudioRecordRecording(elapsed: Duration.zero));
      _startRecordingTimer();
    } catch (e, stackTrace) {
      _logger.e('Erro ao iniciar gravação de áudio', error: e, stackTrace: stackTrace);
      _cancelRecordingTimer();
      emit(
        AudioRecordError(
          failure: UnknownFailure(
            errorMessage: e.toString(),
            stackTrace: stackTrace,
          ),
        ),
      );
    }
  }

  Future<void> pauseRecording() async {
    if (state is! AudioRecordRecording) return;

    try {
      _cancelRecordingTimer();
      await _audioRecorderExternal.pauseRecording();
      _logger.i('Gravação pausada em ${_totalElapsedSeconds}s');
      emit(
        AudioRecordRecordingPaused(
          elapsed: Duration(seconds: _totalElapsedSeconds),
        ),
      );
    } catch (e, stackTrace) {
      _logger.e('Erro ao pausar gravação', error: e, stackTrace: stackTrace);
    }
  }

  Future<void> resumeRecording() async {
    if (state is! AudioRecordRecordingPaused) return;

    try {
      await _audioRecorderExternal.resumeRecording();
      _logger.i('Gravação retomada a partir de ${_totalElapsedSeconds}s');
      emit(
        AudioRecordRecording(
          elapsed: Duration(seconds: _totalElapsedSeconds),
        ),
      );
      _startRecordingTimer();
    } catch (e, stackTrace) {
      _logger.e('Erro ao retomar gravação', error: e, stackTrace: stackTrace);
    }
  }

  Future<void> stopRecording() async {
    _cancelRecordingTimer();
    try {
      final filePath = await _audioRecorderExternal.stopRecording();
      if (filePath == null) {
        emit(const AudioRecordInitial());
        return;
      }

      final duration =
          await _audioPlayerExternal.getDuration(filePath) ??
              const Duration(seconds: 1);

      emit(
        AudioRecordRecorded(
          filePath: filePath,
          totalDuration: duration,
        ),
      );
    } catch (e, stackTrace) {
      _logger.e('Erro ao parar gravação de áudio', error: e, stackTrace: stackTrace);
      emit(
        AudioRecordError(
          failure: UnknownFailure(
            errorMessage: e.toString(),
            stackTrace: stackTrace,
          ),
        ),
      );
    }
  }

  Future<void> playRecording() async {
    final currentState = state;
    String filePath;
    Duration totalDuration;

    if (currentState is AudioRecordRecorded) {
      filePath = currentState.filePath;
      totalDuration = currentState.totalDuration;
    } else if (currentState is AudioRecordPaused) {
      filePath = currentState.filePath;
      totalDuration = currentState.totalDuration;
    } else if (currentState is AudioRecordPlaying) {
      filePath = currentState.filePath;
      totalDuration = currentState.totalDuration;
    } else {
      return;
    }

    try {
      _subscribeToPlayerStreams(filePath, totalDuration);

      if (currentState is AudioRecordPaused) {
        await _audioPlayerExternal.resume();
      } else {
        await _audioPlayerExternal.play(filePath);
      }

      emit(
        AudioRecordPlaying(
          filePath: filePath,
          position: currentState is AudioRecordPaused
              ? currentState.position
              : Duration.zero,
          totalDuration: totalDuration,
        ),
      );
    } catch (e, stackTrace) {
      _logger.e('Erro ao reproduzir áudio', error: e, stackTrace: stackTrace);
      emit(
        AudioRecordError(
          failure: UnknownFailure(
            errorMessage: e.toString(),
            stackTrace: stackTrace,
          ),
        ),
      );
    }
  }

  Future<void> pausePlayback() async {
    final currentState = state;
    if (currentState is! AudioRecordPlaying) return;

    try {
      await _audioPlayerExternal.pause();
      emit(
        AudioRecordPaused(
          filePath: currentState.filePath,
          position: currentState.position,
          totalDuration: currentState.totalDuration,
        ),
      );
    } catch (e, stackTrace) {
      _logger.e('Erro ao pausar reprodução', error: e, stackTrace: stackTrace);
    }
  }

  Future<void> seekTo(Duration position) async {
    try {
      await _audioPlayerExternal.seek(position);
      final currentState = state;
      if (currentState is AudioRecordPlaying) {
        emit(
          AudioRecordPlaying(
            filePath: currentState.filePath,
            position: position,
            totalDuration: currentState.totalDuration,
          ),
        );
      } else if (currentState is AudioRecordPaused) {
        emit(
          AudioRecordPaused(
            filePath: currentState.filePath,
            position: position,
            totalDuration: currentState.totalDuration,
          ),
        );
      }
    } catch (e, stackTrace) {
      _logger.e('Erro ao buscar posição no áudio', error: e, stackTrace: stackTrace);
    }
  }

  Future<void> deleteRecording() async {
    await _stopPlaybackInternal();
    _cancelRecordingTimer();
    _totalElapsedSeconds = 0;
    emit(const AudioRecordInitial());
  }

  // ── Internal helpers ───────────────────────────────────────────────────────

  void _startRecordingTimer() {
    _recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _totalElapsedSeconds++;
      if (!isClosed) {
        emit(
          AudioRecordRecording(
            elapsed: Duration(seconds: _totalElapsedSeconds),
          ),
        );
      }
    });
  }

  void _subscribeToPlayerStreams(String filePath, Duration totalDuration) {
    _positionSubscription?.cancel();
    _completeSubscription?.cancel();

    _positionSubscription = _audioPlayerExternal.onPositionChanged.listen(
      (position) {
        if (isClosed) return;
        final currentState = state;
        if (currentState is AudioRecordPlaying) {
          emit(
            AudioRecordPlaying(
              filePath: filePath,
              position: position,
              totalDuration: currentState.totalDuration,
            ),
          );
        }
      },
    );

    _completeSubscription = _audioPlayerExternal.onPlayerComplete.listen(
      (_) {
        if (isClosed) return;
        emit(
          AudioRecordRecorded(
            filePath: filePath,
            totalDuration: totalDuration,
          ),
        );
      },
    );
  }

  void _cancelRecordingTimer() {
    _recordingTimer?.cancel();
    _recordingTimer = null;
  }

  Future<void> _stopPlaybackInternal() async {
    _positionSubscription?.cancel();
    _positionSubscription = null;
    _completeSubscription?.cancel();
    _completeSubscription = null;
    await _audioPlayerExternal.stop();
  }

  @override
  Future<void> close() async {
    _cancelRecordingTimer();
    _positionSubscription?.cancel();
    _completeSubscription?.cancel();
    await _audioRecorderExternal.dispose();
    await _audioPlayerExternal.dispose();
    return super.close();
  }
}
