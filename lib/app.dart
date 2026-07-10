import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:summary_app/core/env/app_env.dart';
import 'package:summary_app/core/injections/app_injections.dart';
import 'package:summary_app/core/routes/app_routes.dart';
import 'package:summary_app/core/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: AppInjections.repositoryProviders,
      child: MaterialApp.router(
        title: AppEnv.appTitle,
        theme: appTheme,
        routerConfig: appRoutes,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
