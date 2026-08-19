// Caminho: summary_app/lib/core/externals/audio_preprocessor/audio_preprocessor_external_impl.dart

import 'dart:io';
import 'dart:typed_data';
import 'package:summary_app/core/externals/audio_preprocessor/audio_preprocessor_external.dart';

/// Implementação de [IAudioPreprocessorExternal] em Dart puro, sem dependências nativas como FFmpeg.
/// Processa arquivos WAV gravados diretamente com sample rate 16kHz PCM 16-bit Mono.
final class AudioPreprocessorExternalImpl implements IAudioPreprocessorExternal {
  @override
  Future<List<double>> extractAudioFloats(String filePath) async {
    final file = File(filePath);
    if (!await file.exists()) {
      throw Exception('Arquivo de áudio não foi encontrado no caminho: $filePath');
    }

    // 1. Leia o arquivo como bytes.
    final bytes = await file.readAsBytes();

    // 2. Pule o cabeçalho padrão do formato WAV (os primeiros 44 bytes).
    final headerOffset = bytes.length > 44 ? 44 : 0;
    final rawAudioBytes = bytes.sublist(headerOffset);

    final byteData = ByteData.sublistView(rawAudioBytes);
    final sampleCount = rawAudioBytes.length ~/ 2;
    final samples = <double>[];

    // 3 & 4. Itere sobre os bytes restantes de 2 em 2 e extraia int16 little-endian normalizado.
    for (var i = 0; i < sampleCount; i++) {
      final sampleInt16 = byteData.getInt16(i * 2, Endian.little);
      samples.add(sampleInt16 / 32768.0);
    }

    return samples;
  }

  @override
  Future<List<double>> preprocessAudioTo16kMonoPcm(String audioFilePath) =>
      extractAudioFloats(audioFilePath);
}
