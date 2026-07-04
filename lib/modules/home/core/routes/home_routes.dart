import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:summary_app/modules/home/features/presenter/cubits/home_cubit.dart';
import 'package:summary_app/modules/home/features/presenter/pages/home_page.dart';

class HomeRoutes {
  static const String path = '/home';

  static List<RouteBase> get routes => [
        GoRoute(
          path: path,
          builder: (context, state) {
            return BlocProvider<HomeCubit>(
              create: (context) => HomeCubit(),
              child: const HomePage(),
            );
          },
        ),
      ];
}
