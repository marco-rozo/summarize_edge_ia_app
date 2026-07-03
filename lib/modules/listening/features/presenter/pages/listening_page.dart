import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/core/theme/components/summary_app_pulse_button/summary_app_pulse_button.dart';
import 'package:summary_app/core/theme/styles/text_styles.dart';
import 'package:summary_app/modules/listening/features/presenter/cubits/listening_cubit.dart';
import 'package:summary_app/modules/listening/features/presenter/widgets/recognized_text_widget.dart';

class ListeningPage extends StatefulWidget {
  const ListeningPage({super.key});

  @override
  State<ListeningPage> createState() => _ListeningPageState();
}

class _ListeningPageState extends State<ListeningPage> {
  late final ListeningCubit _listeningCubit;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _listeningCubit = context.read<ListeningCubit>();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ouvindo'),
        actions: [
          BlocBuilder<ListeningCubit, ListeningState>(
            bloc: _listeningCubit,
            builder: (_, state) {
              if (state is ListeningPaused || state is ListeningInProgress) {
                return IconButton(
                  icon: const Icon(Icons.refresh_rounded),
                  tooltip: 'Limpar texto',
                  onPressed: () => _listeningCubit.reset(),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: BlocConsumer<ListeningCubit, ListeningState>(
        bloc: _listeningCubit,
        listener: (context, state) {
          if (state is ListeningPermissionDenied) {
            _showPermissionDeniedDialog(context, state.isPermanent);
          }
          if (state is ListeningError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.failure.userMessage,
                  style: AppTextStyle.body14Primary.copyWith(
                    color: AppColors.white,
                  ),
                ),
                backgroundColor: AppColors.negative,
              ),
            );
          }
        },
        builder: (context, state) {
          final bool isListening = state is ListeningInProgress;
          final String recognizedText = switch (state) {
            ListeningInProgress(:final recognizedText) => recognizedText,
            ListeningPaused(:final recognizedText) => recognizedText,
            _ => '',
          };

          return Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isListening
                            ? AppColors.positive
                            : AppColors.borderLight,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isListening
                          ? 'Gravando...'
                          : state is ListeningPaused
                          ? 'Pausado'
                          : 'Pronto para gravar',
                      style: AppTextStyle.body12.copyWith(
                        color: isListening
                            ? AppColors.positive
                            : AppColors.textLightSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Center(
                  child: SummaryAppPulseButton(
                    icon: isListening ? Icons.stop_rounded : Icons.mic_rounded,
                    isActive: isListening,
                    onPressed: () => _listeningCubit.toggleListening(),
                    sizeRatio: 0.4,
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundLightPrimary,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.borderDivider),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withValues(alpha: 0.04),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: RecognizedTextWidget(
                      text: recognizedText,
                      scrollController: _scrollController,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showPermissionDeniedDialog(BuildContext context, bool isPermanent) {
    showDialog(
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
