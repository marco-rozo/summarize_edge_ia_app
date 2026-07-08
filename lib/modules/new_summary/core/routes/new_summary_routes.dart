import 'package:go_router/go_router.dart';
import 'package:summary_app/modules/new_summary/features/presenter/pages/new_summary_page.dart';

class NewSummaryRoutes {
  static const String path = '/new-summary';

  static List<GoRoute> get primaryRoutes => [
        GoRoute(
          path: path,
          builder: (context, state) => const NewSummaryPage(),
        ),
      ];
}
