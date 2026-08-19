import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:summary_app/core/theme/components/summary_shell_scaffold/summary_shell_scaffold.dart';
import 'package:summary_app/modules/ai_models/core/routes/ai_models_routes.dart';
import 'package:summary_app/modules/components/core/routes/components_routes.dart';
import 'package:summary_app/modules/configurations/core/routes/configurations_routes.dart';
import 'package:summary_app/modules/home/core/routes/home_routes.dart';
import 'package:summary_app/modules/listening/core/routes/listening_routes.dart';
import 'package:summary_app/modules/new_summary/core/routes/new_summary_routes.dart';
import 'package:summary_app/modules/onboarding/core/routes/onboarding_routes.dart';
import 'package:summary_app/modules/summarizer/core/routes/summarizer_routes.dart';

final _shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRoutes = GoRouter(
  initialLocation: HomeRoutes.path,
  routes: [
    // ShellRoute — mantém SummaryBottomNavWidget nas telas principais
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => SummaryShellScaffold(child: child),
      routes: [
        ...HomeRoutes.primaryRoutes,
        ...ListeningRoutes.primaryRoutes,
        ...NewSummaryRoutes.primaryRoutes,
        ...ConfigurationsRoutes.primaryRoutes,
      ],
    ),

    // Rotas fora do ShellRoute (tela cheia, sem BottomNav)
    ...ComponentsRoutes.routes,
    ...OnboardingRoutes.routes,
    ...AiModelsRoutes.routes,
    ...SummarizerRoutes.routes,
  ],
);
