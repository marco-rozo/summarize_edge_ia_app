import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:summary_app/core/env/app_env.dart';
import 'package:summary_app/core/externals/permission_manager/permission_manager.dart';
import 'package:summary_app/core/externals/permission_manager/permission_manager_impl.dart';
import 'package:summary_app/core/externals/speech_recognizer/speech_recognizer.dart';
import 'package:summary_app/core/externals/speech_recognizer/speech_recognizer_impl.dart';
import 'package:summary_app/core/router/app_router.dart';
import 'package:summary_app/core/theme/theme.dart';
import 'package:summary_app/modules/ai_models/core/injections/ai_models_injections.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        // Externals
        RepositoryProvider<PermissionManager>(
          create: (_) => PermissionManagerImpl(),
        ),
        RepositoryProvider<SpeechRecognizer>(
          create: (_) => SpeechRecognizerImpl(),
        ),
        // AI Models Module
        ...AiModelsInjections.repositoryProviders,
      ],
      child: MaterialApp.router(
        title: AppEnv.appTitle,
        theme: appTheme,
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
