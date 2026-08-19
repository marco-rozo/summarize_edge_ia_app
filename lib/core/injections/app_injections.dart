import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:summary_app/core/injections/externals_injections.dart';
import 'package:summary_app/modules/ai_models/core/injections/ai_models_injections.dart';
import 'package:summary_app/modules/home/core/injections/home_injections.dart';
import 'package:summary_app/modules/listening/core/injections/listening_injections.dart';
import 'package:summary_app/modules/summarizer/core/injections/summarizer_injections.dart';

final class AppInjections {
  static List<RepositoryProvider> get repositoryProviders => [
        ...ExternalsInjections.repositoryProviders,
        ...HomeInjections.repositoryProviders,
        ...ListeningInjections.repositoryProviders,
        ...AiModelsInjections.repositoryProviders,
        ...SummarizerInjections.repositoryProviders,
      ];
}
