import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:summary_app/core/externals/permission_manager/permission_manager.dart';
import 'package:summary_app/core/externals/speech_recognizer/speech_recognizer.dart';
import 'package:summary_app/modules/listening/features/presenter/cubits/listening_cubit.dart';
import 'package:summary_app/modules/listening/features/presenter/pages/listening_page.dart';

final class ListeningRoutes {
  static const String path = '/listening';

  static List<GoRoute> get routes => [
    GoRoute(
      path: path,
      builder: (context, _) => BlocProvider<ListeningCubit>(
        create: (context) => ListeningCubit(
          speechRecognizer: context.read<SpeechRecognizer>(),
          permissionManager: context.read<PermissionManager>(),
          logger: Logger(),
        )..init(),
        child: const ListeningPage(),
      ),
    ),
  ];
}
