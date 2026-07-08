import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/core/theme/components/summary_app_background/summary_app_background.dart';
import 'package:summary_app/core/theme/components/summary_app_bar/summary_app_bar.dart';
import 'package:summary_app/core/theme/components/summary_app_button/summary_app_button.dart';
import 'package:summary_app/core/theme/components/summary_app_pulse_button/summary_app_pulse_button.dart';
import 'package:summary_app/core/theme/styles/text_styles.dart';
import 'package:summary_app/modules/listening/features/presenter/cubits/listening_cubit.dart';
import 'package:summary_app/modules/listening/features/presenter/widgets/status_indicator_widget.dart';
import 'package:summary_app/modules/listening/features/presenter/widgets/waveform_widget.dart';

class ListeningPage extends StatefulWidget {
  const ListeningPage({super.key});

  @override
  State<ListeningPage> createState() => _ListeningPageState();
}

class _ListeningPageState extends State<ListeningPage>
    with SingleTickerProviderStateMixin {
  late final ListeningCubit _listeningCubit;

  /// Elapsed-recording timer.
  int _elapsedSeconds = 0;
  bool _timerRunning = false;

  @override
  void initState() {
    super.initState();
    _listeningCubit = context.read<ListeningCubit>();
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

  // ── State derivation ───────────────────────────────────────────────────────

  StatusIndicatorState _statusFrom(ListeningState state) {
    if (state is ListeningInProgress) return StatusIndicatorState.recording;
    if (state is ListeningPaused && state.recognizedText.isNotEmpty) {
      return StatusIndicatorState.captured;
    }
    return StatusIndicatorState.ready;
  }

  @override
  void dispose() {
    _timerRunning = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListeningCubit, ListeningState>(
      bloc: _listeningCubit,
      listener: _onStateChange,
      builder: (context, state) {
        final bool isListening = state is ListeningInProgress;
        final bool hasCaptured =
            state is ListeningPaused && state.recognizedText.isNotEmpty;
        final StatusIndicatorState indicatorStatus = _statusFrom(state);

        return Scaffold(
          backgroundColor: AppColors.transparent,
          appBar: SummaryAppBar(
            showBackButton: false,
            titleWidget: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(width: 10),
                const Icon(
                  Icons.memory_rounded,
                  color: AppColors.primary,
                  size: 22,
                ),
                const SizedBox(width: 8),
                Text(
                  'Edge AI Summary',
                  style: AppTextStyle.headlineMd.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            actions: [
              if (state is ListeningPaused || state is ListeningInProgress)
                IconButton(
                  icon: const Icon(
                    Icons.refresh_rounded,
                    color: AppColors.onSurfaceVariant,
                  ),
                  tooltip: 'Limpar',
                  onPressed: () {
                    _resetTimer();
                    _listeningCubit.reset();
                  },
                ),
            ],
          ),
          body: SummaryAppBackground(
            child: SafeArea(
              top: false,
              child: Stack(
                children: [
                  // ── Main centered content ──────────────────────────────────
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Status chip + timer
                        _StatusSection(
                          indicatorStatus: indicatorStatus,
                          timerLabel: _timerLabel,
                          showTimer: isListening || _elapsedSeconds > 0,
                        ),

                        const SizedBox(height: 40),

                        // Recording area: waveform behind pulse button
                        _RecordingArea(
                          isListening: isListening,
                          onTap: () => _listeningCubit.toggleListening(),
                        ),
                      ],
                    ),
                  ),

                  // ── Summarize CTA (slides up when audio is captured) ───────
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeOutCubic,
                    bottom: hasCaptured ? 32 : -120,
                    left: 24,
                    right: 24,
                    child: IgnorePointer(
                      ignoring: !hasCaptured,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: hasCaptured ? 1.0 : 0.0,
                        child: SummaryAppButton.primary(
                          leftIcon: Icons.auto_awesome_rounded,
                          text: 'Resumir com IA',
                          onPressed: hasCaptured ? _onSummarize : null,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ── Event handlers ─────────────────────────────────────────────────────────

  void _onStateChange(BuildContext context, ListeningState state) {
    if (state is ListeningInProgress) {
      _startTimer();
    } else if (state is ListeningPaused) {
      _stopTimer();
    } else if (state is ListeningInitial) {
      _resetTimer();
    } else if (state is ListeningPermissionDenied) {
      _stopTimer();
      _showPermissionDeniedDialog(context, state.isPermanent);
    } else if (state is ListeningError) {
      _stopTimer();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            state.failure.userMessage,
            style: AppTextStyle.body14Primary.copyWith(
              color: AppColors.onSurface,
            ),
          ),
          backgroundColor: AppColors.negativeContainer,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _onSummarize() {
    // TODO: navigate to summary generation screen.
    _listeningCubit.summaryWithIaModel();
  }

  void _showPermissionDeniedDialog(BuildContext context, bool isPermanent) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Permissão necessária'),
        content: Text(
          isPermanent
              ? 'A permissão de microfone foi negada permanentemente. '
                    'Abra as configurações do app para permitir o acesso.'
              : 'É necessário permitir o acesso ao microfone para '
                    'utilizar o reconhecimento de voz.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancelar'),
          ),
          if (isPermanent)
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _listeningCubit.openSettings();
              },
              child: const Text('Abrir Configurações'),
            ),
        ],
      ),
    );
  }
}

// ── Private sub-widgets ──────────────────────────────────────────────────────

/// Status chip + elapsed timer stacked vertically.
class _StatusSection extends StatelessWidget {
  const _StatusSection({
    required this.indicatorStatus,
    required this.timerLabel,
    required this.showTimer,
  });

  final StatusIndicatorState indicatorStatus;
  final String timerLabel;
  final bool showTimer;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        StatusIndicatorWidget(status: indicatorStatus),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: showTimer
              ? Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: showTimer ? 1.0 : 0.0,
                    child: Text(
                      timerLabel,
                      style: AppTextStyle.headlineLgMobile.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.6,
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

/// Circular recording area that layers the waveform behind the pulse button.
class _RecordingArea extends StatelessWidget {
  const _RecordingArea({required this.isListening, required this.onTap});

  final bool isListening;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final double areaSize = MediaQuery.sizeOf(context).width * 0.72;

    return SizedBox(
      width: areaSize,
      height: areaSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Waveform (behind button)
          WaveformWidget(isActive: isListening),

          // Glassy ring (always visible, subtly highlights when recording)
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            width: areaSize * 0.58,
            height: areaSize * 0.58,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isListening
                    ? AppColors.primary.withValues(alpha: 0.18)
                    : AppColors.white.withValues(alpha: 0.04),
                width: 1,
              ),
              boxShadow: isListening
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.20),
                        blurRadius: 40,
                        spreadRadius: 4,
                      ),
                    ]
                  : [],
            ),
          ),

          // Pulse button (foreground)
          SummaryAppPulseButton(
            icon: isListening ? Icons.stop_rounded : Icons.mic_rounded,
            isActive: isListening,
            onPressed: onTap,
            sizeRatio: 0.38,
          ),
        ],
      ),
    );
  }
}
