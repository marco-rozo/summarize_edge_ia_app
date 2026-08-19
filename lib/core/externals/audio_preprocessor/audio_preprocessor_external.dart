// Caminho: summary_app/lib/core/externals/audio_preprocessor/audio_preprocessor_external.dart

/// Interface para pré-processamento de áudio externo em Dart puro.
/// Lê arquivos WAV gravados em 16kHz PCM Mono e extrai as amostras de float prontas para inferência.
abstract interface class IAudioPreprocessorExternal {
  /// Extrai as amostras float [List<double>] de um arquivo WAV em [filePath] em Dart puro.
  Future<List<double>> extractAudioFloats(String filePath);

  /// Método de conveniência/compatibilidade para extração de amostras PCM float [List<double>].
  Future<List<double>> preprocessAudioTo16kMonoPcm(String audioFilePath);
}
