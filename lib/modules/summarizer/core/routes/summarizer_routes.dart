// Caminho: summary_app/lib/modules/summarizer/core/routes/summarizer_routes.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:summary_app/modules/summarizer/features/domain/usecases/transcribe_audio_usecase.dart';
import 'package:summary_app/modules/summarizer/features/presenter/cubits/summarizer_cubit.dart';
import 'package:summary_app/modules/summarizer/features/presenter/pages/summarizer_page.dart';

final class SummarizerRoutes {
  static const String path = '/summarizer';

  static List<GoRoute> get routes => [
        GoRoute(
          path: path,
          builder: (context, state) {
            final audioPath = (state.extra as String?) ??
                state.uri.queryParameters['audioFilePath'] ??
                '';
            return BlocProvider<SummarizerCubit>(
              create: (context) => SummarizerCubit(
                transcribeAudioUsecase: context.read<TranscribeAudioUsecase>(),
                logger: Logger(),
              ),
              child: SummarizerPage(audioFilePath: audioPath),
            );
          },
        ),
      ];
}
