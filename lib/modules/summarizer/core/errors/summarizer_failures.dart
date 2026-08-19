// Caminho: summary_app/lib/modules/summarizer/core/errors/summarizer_failures.dart

import 'package:summary_app/core/errors/failure.dart';

/// Falha emitida quando nenhum modelo ASR ('audio-to-text') local está baixado ou disponível.
class ModelNotAvailableFailure extends Failure {
  ModelNotAvailableFailure({super.errorMessage, super.stackTrace});

  @override
  String get userMessage =>
      errorMessage ?? 'Nenhum modelo de transcrição (audio-to-text) disponível localmente.';
}

/// Falha emitida quando ocorre erro na conversão do áudio (pre-processing).
class AudioProcessingFailure extends Failure {
  AudioProcessingFailure({super.errorMessage, super.stackTrace});

  @override
  String get userMessage =>
      errorMessage ?? 'Erro ao pré-processar o arquivo de áudio.';
}

/// Falha emitida quando ocorre erro durante a execução da inferência ASR.
class AsrInferenceFailure extends Failure {
  AsrInferenceFailure({super.errorMessage, super.stackTrace});

  @override
  String get userMessage =>
      errorMessage ?? 'Erro ao executar a transcrição do áudio com IA.';
}
