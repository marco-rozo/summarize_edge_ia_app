// Caminho: summary_app/lib/modules/summarizer/features/presenter/cubits/summarizer_cubit.dart

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:summary_app/core/errors/failure.dart';
import 'package:summary_app/modules/summarizer/features/domain/usecases/transcribe_audio_usecase.dart';

part 'summarizer_state.dart';

/// Cubit responsável por gerenciar o estado da tela de transcrição local (SummarizerPage).
class SummarizerCubit extends Cubit<SummarizerState> {
  SummarizerCubit({
    required TranscribeAudioUsecase transcribeAudioUsecase,
    Logger? logger,
  })  : _transcribeAudioUsecase = transcribeAudioUsecase,
        _logger = logger ?? Logger(),
        super(const SummarizerInitial());

  final TranscribeAudioUsecase _transcribeAudioUsecase;
  final Logger _logger;

  Future<void> processAudio(String audioFilePath) async {
    emit(const SummarizerLoading());

    _logger.i('Iniciando processamento ASR local para áudio: $audioFilePath');
    final result = await _transcribeAudioUsecase(audioFilePath);

    result.fold(
      (failure) {
        _logger.e('Erro ao transcrever áudio: ${failure.errorMessage}');
        emit(SummarizerError(failure: failure));
      },
      (transcribedText) {
        _logger.i('Transcrição gerada com sucesso: $transcribedText');
        emit(SummarizerSuccess(transcribedText: transcribedText));
      },
    );
  }
}
