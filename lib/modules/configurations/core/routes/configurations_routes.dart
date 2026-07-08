import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:summary_app/modules/configurations/features/presenter/cubits/configurations_cubit.dart';
import 'package:summary_app/modules/configurations/features/presenter/pages/configurations_page.dart';

class ConfigurationsRoutes {
  static const String path = '/configurations';

  static List<GoRoute> get primaryRoutes => [
        GoRoute(
          path: path,
          builder: (context, state) {
            return BlocProvider<ConfigurationsCubit>(
              create: (_) => ConfigurationsCubit(),
              child: const ConfigurationsPage(),
            );
          },
        ),
      ];

  /// Alias — rotas fora do ShellRoute (mantido para compatibilidade futura).
  static List<RouteBase> get routes => primaryRoutes;
}
