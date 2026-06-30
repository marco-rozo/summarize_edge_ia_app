import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:summary_app/core/router/app_named_routes.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/core/theme/components/my_app_button/my_app_button.dart';
import 'package:summary_app/modules/chat/core/routes/chat_routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppNamedRoutes.home,
  routes: [
    GoRoute(
      name: AppNamedRoutes.home,
      path: AppNamedRoutes.home,
      builder: (context, state) => const _HomePage(),
    ),
    ...ChatRoutes.routes,
  ],
);

class _HomePage extends StatelessWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLightSecondary,
      appBar: AppBar(title: const Text('Home')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyAppButton.primary(
              text: 'Abrir Chat',
              leftIcon: Icons.chat_bubble_outline_rounded,
              onPressed: () => context.push(AppNamedRoutes.chat),
            ),
            const SizedBox(height: 16),
            MyAppButton.secondary(
              text: 'Botão Secundário',
              onPressed: () {},
            ),
            const SizedBox(height: 16),
            MyAppButton.negative(
              text: 'Botão Negativo',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
