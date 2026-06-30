import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:summary_app/core/theme/components/my_app_button/my_app_button.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const _HomePage(),
    ),
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
            MyAppButton.primary(
              text: 'Botão Primário',
              onPressed: () {},
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
