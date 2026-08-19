import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/modules/listening/features/presenter/cubits/audio_record_cubit.dart';
import 'package:summary_app/modules/listening/features/presenter/cubits/listening_cubit.dart';
import 'package:summary_app/modules/listening/features/presenter/widgets/listening_app_bar/listening_app_bar_widget.dart';
import 'package:summary_app/modules/listening/features/presenter/widgets/listening_body/listening_body_widget.dart';
import 'package:summary_app/modules/listening/features/presenter/widgets/permission_denied_dialog/permission_denied_dialog_widget.dart';
import 'package:summary_app/modules/listening/features/presenter/widgets/status/status_indicator_widget.dart';
import 'package:summary_app/modules/summarizer/core/routes/summarizer_routes.dart';

class ListeningPage extends StatefulWidget {
  const ListeningPage({super.key});

  @override
  State<ListeningPage> createState() => _ListeningPageState();
}

class _ListeningPageState extends State<ListeningPage>
    with SingleTickerProviderStateMixin {
  late final ListeningCubit _listeningCubit;
  late final AudioRecordCubit _audioRecordCubit;

  /// Elapsed-recording timer.
  int _elapsedSeconds = 0;
  bool _timerRunning = false;

  @override
  void initState() {
    super.initState();
    _listeningCubit = context.read<ListeningCubit>();
    _audioRecordCubit = context.read<AudioRecordCubit>();
  }

  // ── Timer helpers ──────────────────────────────────────────────────────────

  void _startTimer() {
    if (_timerRunning) return;
    _timerRunning = true;
    _tick();
  }

  void _tick() {
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted || !_timerRunning) return;
      setState(() => _elapsedSeconds++);
      _tick();
    });
  }

  void _stopTimer() {
    _timerRunning = false;
  }

  void _resetTimer() {
    _timerRunning = false;
    _elapsedSeconds = 0;
  }

  String get _timerLabel {
    final mins = (_elapsedSeconds ~/ 60).toString().padLeft(2, '0');
    final secs = (_elapsedSeconds % 60).toString().padLeft(2, '0');
    return '$mins:$secs';
  }

  @override
  void dispose() {
    _timerRunning = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ListeningCubit, ListeningState>(
      bloc: _listeningCubit,
      listener: _onListeningStateChange,
      child: BlocBuilder<AudioRecordCubit, AudioRecordState>(
        bloc: _audioRecordCubit,
        builder: (context, audioState) {
          final bool hasRecordedAudio =
              audioState is AudioRecordRecorded ||
              audioState is AudioRecordPlaying ||
              audioState is AudioRecordPaused;

          Duration currentPosition = Duration.zero;
          Duration totalDuration = Duration.zero;
          if (audioState is AudioRecordRecorded) {
            totalDuration = audioState.totalDuration;
          } else if (audioState is AudioRecordPlaying) {
            currentPosition = audioState.position;
            totalDuration = audioState.totalDuration;
          } else if (audioState is AudioRecordPaused) {
            currentPosition = audioState.position;
            totalDuration = audioState.totalDuration;
          }

          final StatusIndicatorState indicatorStatus = hasRecordedAudio
              ? StatusIndicatorState.captured
              : (audioState is AudioRecordRecording ||
                    audioState is AudioRecordRecordingPaused)
              ? StatusIndicatorState.recording
              : StatusIndicatorState.ready;

          return Scaffold(
            backgroundColor: AppColors.transparent,
            appBar: ListeningAppBarWidget(
              showClearButton: audioState is AudioRecordRecording ||
                  audioState is AudioRecordRecordingPaused ||
                  hasRecordedAudio,
              onClearPressed: () {
                _resetTimer();
                _audioRecordCubit.deleteRecording();
              },
            ),
            body: ListeningBodyWidget(
              indicatorStatus: indicatorStatus,
              timerLabel: _timerLabel,
              showTimer: audioState is AudioRecordRecording ||
                  audioState is AudioRecordRecordingPaused,
              isRecording: audioState is AudioRecordRecording,
              isPaused: audioState is AudioRecordRecordingPaused,
              hasRecordedAudio: hasRecordedAudio,
              isPlaying: audioState is AudioRecordPlaying,
              currentPosition: currentPosition,
              totalDuration: totalDuration,
              onPulseTap: () {
                if (audioState is AudioRecordRecording) {
                  _audioRecordCubit.pauseRecording();
                  _stopTimer();
                } else if (audioState is AudioRecordRecordingPaused) {
                  _audioRecordCubit.resumeRecording();
                  _startTimer();
                } else {
                  _onStartRecording(audioState);
                }
              },
              onStopRecording: () {
                _audioRecordCubit.stopRecording();
                _resetTimer();
              },
              onPlayPause: () {
                if (audioState is AudioRecordPlaying) {
                  _audioRecordCubit.pausePlayback();
                } else {
                  _audioRecordCubit.playRecording();
                }
              },
              onSeek: (pos) => _audioRecordCubit.seekTo(pos),
              onDeleteRecording: () => _audioRecordCubit.deleteRecording(),
              onSummarize: _onSummarize,
            ),
          );
        },
      ),
    );
  }

  // ── Event handlers ─────────────────────────────────────────────────────────

  Future<void> _onStartRecording(AudioRecordState audioState) async {
    // Check microphone permission before recording
    await _listeningCubit.checkMicrophonePermission();

    if (!mounted) return;
    final listenState = _listeningCubit.state;
    if (listenState is ListeningPermissionDenied) return;

    // Permission granted — start audio recording
    if (audioState is AudioRecordRecorded ||
        audioState is AudioRecordPlaying ||
        audioState is AudioRecordPaused) {
      _audioRecordCubit.deleteRecording();
    }
    _resetTimer();
    _audioRecordCubit.startRecording();
    _startTimer();
  }

  void _onListeningStateChange(BuildContext context, ListeningState state) {
    if (state is ListeningPermissionDenied) {
      _showPermissionDeniedDialog(context, state.isPermanent);
    }
  }

  void _onSummarize() {
    String? audioPath;
    final audioState = _audioRecordCubit.state;
    if (audioState is AudioRecordRecorded) {
      audioPath = audioState.filePath;
    } else if (audioState is AudioRecordPlaying) {
      audioPath = audioState.filePath;
    } else if (audioState is AudioRecordPaused) {
      audioPath = audioState.filePath;
    }
    if (audioPath != null && audioPath.isNotEmpty) {
      context.push(SummarizerRoutes.path, extra: audioPath);
    }
  }

  void _showPermissionDeniedDialog(BuildContext context, bool isPermanent) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => PermissionDeniedDialogWidget(
        isPermanent: isPermanent,
        onOpenSettings: _listeningCubit.openSettings,
      ),
    );
  }
}
