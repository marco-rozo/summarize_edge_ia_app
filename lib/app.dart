import 'package:flutter/material.dart';
import 'package:summary_app/core/env/app_env.dart';
import 'package:summary_app/core/router/app_router.dart';
import 'package:summary_app/core/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppEnv.appTitle,
      theme: appTheme,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
