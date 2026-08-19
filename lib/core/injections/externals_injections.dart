import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:summary_app/core/externals/asr_inference/asr_inference_external.dart';
import 'package:summary_app/core/externals/asr_inference/asr_inference_external_impl.dart';
import 'package:summary_app/core/externals/audio_player/audio_player_external.dart';
import 'package:summary_app/core/externals/audio_player/audio_player_external_impl.dart';
import 'package:summary_app/core/externals/audio_preprocessor/audio_preprocessor_external.dart';
import 'package:summary_app/core/externals/audio_preprocessor/audio_preprocessor_external_impl.dart';
import 'package:summary_app/core/externals/audio_recorder/audio_recorder_external.dart';
import 'package:summary_app/core/externals/audio_recorder/audio_recorder_external_impl.dart';
import 'package:summary_app/core/externals/permission_manager/permission_manager.dart';
import 'package:summary_app/core/externals/permission_manager/permission_manager_impl.dart';

final class ExternalsInjections {
  static List<RepositoryProvider> get repositoryProviders => [
        RepositoryProvider<PermissionManager>(
          create: (_) => PermissionManagerImpl(),
        ),
        RepositoryProvider<IAudioRecorderExternal>(
          create: (context) => AudioRecorderExternalImpl(
            permissionManager: context.read<PermissionManager>(),
          ),
        ),
        RepositoryProvider<IAudioPlayerExternal>(
          create: (_) => AudioPlayerExternalImpl(),
        ),
        RepositoryProvider<IAudioPreprocessorExternal>(
          create: (_) => AudioPreprocessorExternalImpl(),
        ),
        RepositoryProvider<IAsrInferenceExternal>(
          create: (_) => AsrInferenceExternalImpl(),
        ),
      ];
}
