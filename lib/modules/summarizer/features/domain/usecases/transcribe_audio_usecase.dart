// Caminho: summary_app/lib/modules/summarizer/features/domain/usecases/transcribe_audio_usecase.dart

import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:path_provider/path_provider.dart';
import 'package:summary_app/core/externals/asr_inference/asr_inference_external.dart';
import 'package:summary_app/core/externals/audio_preprocessor/audio_preprocessor_external.dart';
import 'package:summary_app/core/utils/typedefs.dart';
import 'package:summary_app/modules/ai_models/features/domain/enums/ai_model_task_type_enum.dart';
import 'package:summary_app/modules/ai_models/features/domain/repositories/ai_model_repository.dart';
import 'package:summary_app/modules/summarizer/core/errors/summarizer_failures.dart';

/// Caso de uso responsável por orquestrar a transcrição de um arquivo de áudio:
/// 1) Busca na base de modelos qual possui taskType == 'audio-to-text' e está baixado.
/// 2) Pré-processa o áudio para amostras PCM Mono 16kHz.
/// 3) Executa a inferência no modelo TFLite.
class TranscribeAudioUsecase {
  TranscribeAudioUsecase({
    required AiModelRepository aiModelRepository,
    required IAudioPreprocessorExternal audioPreprocessorExternal,
    required IAsrInferenceExternal asrInferenceExternal,
  })  : _aiModelRepository = aiModelRepository,
        _audioPreprocessorExternal = audioPreprocessorExternal,
        _asrInferenceExternal = asrInferenceExternal;

  final AiModelRepository _aiModelRepository;
  final IAudioPreprocessorExternal _audioPreprocessorExternal;
  final IAsrInferenceExternal _asrInferenceExternal;

  Future<Output<String>> call(String audioFilePath) async {
    try {
      final modelsResult = await _aiModelRepository.getAllModels();

      return await modelsResult.fold(
        (failure) async => Left(ModelNotAvailableFailure(
          errorMessage: failure.errorMessage,
          stackTrace: failure.stackTrace,
        )),
        (models) async {
          final audioModels = models.where(
            (model) =>
                model.taskType == 'audio-to-text' ||
                model.taskTypeEnum == AiModelTaskTypeEnum.audioToText,
          );

          final directory = await getApplicationSupportDirectory();
          String? availableModelPath;

          for (final model in audioModels) {
            final path = '${directory.path}/${model.fileName}';
            if (await File(path).exists()) {
              availableModelPath = path;
              break;
            }
          }

          if (availableModelPath == null) {
            return Left(
              ModelNotAvailableFailure(
                errorMessage:
                    'Nenhum modelo ASR (audio-to-text) baixado e disponível para inferência.',
              ),
            );
          }

          List<double> audioSamples;
          try {
            audioSamples = await _audioPreprocessorExternal
                .extractAudioFloats(audioFilePath);
          } catch (e, st) {
            return Left(
              AudioProcessingFailure(errorMessage: e.toString(), stackTrace: st),
            );
          }

          try {
            final text = await _asrInferenceExternal.runInference(
              modelPath: availableModelPath,
              audioSamples: audioSamples,
            );
            return Right(text);
          } catch (e, st) {
            return Left(
              AsrInferenceFailure(errorMessage: e.toString(), stackTrace: st),
            );
          }
        },
      );
    } catch (e, st) {
      return Left(
        AsrInferenceFailure(errorMessage: e.toString(), stackTrace: st),
      );
    }
  }
}
