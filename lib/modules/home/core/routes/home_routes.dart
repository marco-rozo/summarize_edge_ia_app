import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:summary_app/modules/home/features/presenter/cubits/home_cubit.dart';
import 'package:summary_app/modules/home/features/presenter/pages/home_page.dart';

class HomeRoutes {
  static const String path = '/home';

  static List<GoRoute> get primaryRoutes => [
        GoRoute(
          path: path,
          builder: (context, state) {
            return BlocProvider<HomeCubit>(
              create: (_) => HomeCubit(),
              child: const HomePage(),
            );
          },
        ),
      ];

  /// Alias — rotas fora do ShellRoute (mantido para compatibilidade futura).
  static List<RouteBase> get routes => primaryRoutes;
}
