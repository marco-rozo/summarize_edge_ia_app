// Caminho: summary_app/lib/core/externals/asr_inference/asr_inference_external_impl.dart

import 'package:logger/logger.dart';
import 'package:summary_app/core/externals/asr_inference/asr_inference_external.dart';

/// Implementação limpa sem dependência do tflite_flutter.
final class AsrInferenceExternalImpl implements IAsrInferenceExternal {
  AsrInferenceExternalImpl({Logger? logger}) : _logger = logger ?? Logger();

  final Logger _logger;

  @override
  Future<String> runInference({
    required String modelPath,
    required List<double> audioSamples,
  }) async {
    _logger.i('ASR Inference: pacote tflite_flutter removido conforme solicitado.');
    return '';
  }
}
