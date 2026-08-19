// Caminho: summary_app/lib/core/externals/asr_inference/asr_inference_external.dart

/// Interface para execução de inferência local de transcrição de áudio (ASR).
abstract interface class IAsrInferenceExternal {
  /// Executa o modelo `.tflite` localizado em [modelPath] com as amostras de áudio [audioSamples]
  /// e retorna o texto transcrito.
  Future<String> runInference({
    required String modelPath,
    required List<double> audioSamples,
  });
}
