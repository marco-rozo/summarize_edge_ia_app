import 'package:go_router/go_router.dart';
import 'package:summary_app/modules/components/core/routes/components_routes.dart';
import 'package:summary_app/modules/listening/core/routes/listening_routes.dart';
import 'package:summary_app/modules/onboarding/core/routes/onboarding_routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: OnboardingRoutes.path,
  routes: [
    ...ComponentsRoutes.routes,
    ...ListeningRoutes.routes,
    ...OnboardingRoutes.routes,
  ],
);
