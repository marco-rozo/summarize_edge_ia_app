import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:summary_app/core/theme/components/summary_bottom_nav_widget/summary_bottom_nav_widget.dart';
import 'package:summary_app/modules/configurations/core/routes/configurations_routes.dart';
import 'package:summary_app/modules/home/core/routes/home_routes.dart';
import 'package:summary_app/modules/listening/core/routes/listening_routes.dart';

/// Scaffold wrapper used by the [ShellRoute] to keep the [SummaryBottomNavWidget]
/// persistent across the primary navigation tabs (Home, Listening, Settings).
class SummaryShellScaffold extends StatelessWidget {
  const SummaryShellScaffold({super.key, required this.child});

  final Widget child;

  static final List<String> _tabPaths = [
    HomeRoutes.path,
    ListeningRoutes.path,
    ConfigurationsRoutes.path,
  ];

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final index = _tabPaths.indexWhere(
      (path) => location.startsWith(path),
    );
    return index < 0 ? 0 : index;
  }

  void _onTap(BuildContext context, int index) {
    context.go(_tabPaths[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: SummaryBottomNavWidget(
        currentIndex: _currentIndex(context),
        onTap: (index) => _onTap(context, index),
      ),
    );
  }
}
