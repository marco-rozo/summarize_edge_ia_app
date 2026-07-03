import 'package:go_router/go_router.dart';
import 'package:summary_app/modules/components/features/presenter/pages/background_test_page.dart';
import 'package:summary_app/modules/components/features/presenter/pages/components_page.dart';

final class ComponentsRoutes {
  static const String path = '/';
  static const String backgroundTestPath = '/background-test';

  static List<GoRoute> get routes => [
    GoRoute(path: path, builder: (context, state) => const ComponentsPage()),
    GoRoute(
      path: backgroundTestPath,
      builder: (context, state) => const BackgroundTestPage(),
    ),
  ];
}
