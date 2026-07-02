import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:summary_app/core/theme/components/my_app_button/my_app_button.dart';
import 'package:summary_app/modules/listening/core/routes/listening_routes.dart';
import 'package:summary_app/modules/onboarding/core/routes/onboarding_routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: OnboardingRoutes.path,
  routes: [
    GoRoute(path: '/', builder: (context, state) => const _HomePage()),
    ...ListeningRoutes.routes,
    ...OnboardingRoutes.routes,
  ],
);

class _HomePage extends StatelessWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyAppButton.primary(text: 'Botão Primário', onPressed: () {}),
            const SizedBox(height: 16),
            MyAppButton.secondary(text: 'Botão Secundário', onPressed: () {}),
            const SizedBox(height: 16),
            MyAppButton.negative(text: 'Botão Negativo', onPressed: () {}),
            const SizedBox(height: 32),
            MyAppButton.primary(
              text: 'Reconhecimento de Voz',
              rightIcon: Icons.mic_rounded,
              onPressed: () => context.push(ListeningRoutes.path),
            ),
            const SizedBox(height: 16),
            MyAppButton.secondary(
              text: 'Ver Onboarding',
              leftIcon: Icons.auto_awesome_rounded,
              onPressed: () => context.push(OnboardingRoutes.path),
            ),
          ],
        ),
      ),
    );
  }
}
