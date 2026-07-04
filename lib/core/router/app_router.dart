import 'package:go_router/go_router.dart';
import 'package:summary_app/modules/ai_models/core/routes/ai_models_routes.dart';
import 'package:summary_app/modules/components/core/routes/components_routes.dart';
import 'package:summary_app/modules/home/core/routes/home_routes.dart';
import 'package:summary_app/modules/listening/core/routes/listening_routes.dart';
import 'package:summary_app/modules/onboarding/core/routes/onboarding_routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: HomeRoutes.path,
  routes: [
    ...ComponentsRoutes.routes,
    ...ListeningRoutes.routes,
    ...OnboardingRoutes.routes,
    ...AiModelsRoutes.routes,
    ...HomeRoutes.routes,
  ],
);
