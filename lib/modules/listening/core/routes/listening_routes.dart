import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:summary_app/core/externals/audio_player/audio_player_external.dart';
import 'package:summary_app/core/externals/audio_recorder/audio_recorder_external.dart';
import 'package:summary_app/core/externals/permission_manager/permission_manager.dart';
import 'package:summary_app/modules/listening/features/presenter/cubits/audio_record_cubit.dart';
import 'package:summary_app/modules/listening/features/presenter/cubits/listening_cubit.dart';
import 'package:summary_app/modules/listening/features/presenter/pages/listening_page.dart';

final class ListeningRoutes {
  static const String path = '/listening';

  static List<GoRoute> get primaryRoutes => [
    GoRoute(
      path: path,
      builder: (context, _) => MultiBlocProvider(
        providers: [
          BlocProvider<ListeningCubit>(
            create: (context) => ListeningCubit(
              permissionManager: context.read<PermissionManager>(),
              logger: Logger(),
            ),
          ),
          BlocProvider<AudioRecordCubit>(
            create: (context) => AudioRecordCubit(
              audioRecorderExternal: context.read<IAudioRecorderExternal>(),
              audioPlayerExternal: context.read<IAudioPlayerExternal>(),
              logger: Logger(),
            ),
          ),
        ],
        child: const ListeningPage(),
      ),
    ),
  ];

  static List<GoRoute> get routes => primaryRoutes;
}
