// Caminho: summary_app/lib/modules/summarizer/core/injections/summarizer_injections.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:summary_app/core/externals/asr_inference/asr_inference_external.dart';
import 'package:summary_app/core/externals/audio_preprocessor/audio_preprocessor_external.dart';
import 'package:summary_app/modules/ai_models/features/domain/repositories/ai_model_repository.dart';
import 'package:summary_app/modules/summarizer/features/domain/usecases/transcribe_audio_usecase.dart';

/// Centraliza os provedores de injeção de dependência do módulo [summarizer].
final class SummarizerInjections {
  static List<RepositoryProvider> get repositoryProviders => [
        RepositoryProvider<TranscribeAudioUsecase>(
          create: (context) => TranscribeAudioUsecase(
            aiModelRepository: context.read<AiModelRepository>(),
            audioPreprocessorExternal:
                context.read<IAudioPreprocessorExternal>(),
            asrInferenceExternal: context.read<IAsrInferenceExternal>(),
          ),
        ),
      ];
}
