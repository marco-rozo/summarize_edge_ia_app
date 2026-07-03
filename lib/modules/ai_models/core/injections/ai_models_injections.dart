import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:summary_app/modules/ai_models/features/data/datasources/ai_model_datasource.dart';
import 'package:summary_app/modules/ai_models/features/data/datasources/ai_model_datasource_impl.dart';
import 'package:summary_app/modules/ai_models/features/data/repositories/ai_model_repository_impl.dart';
import 'package:summary_app/modules/ai_models/features/domain/repositories/ai_model_repository.dart';
import 'package:summary_app/modules/ai_models/features/domain/usecases/download_ai_model_usecase.dart';
import 'package:summary_app/modules/ai_models/features/domain/usecases/download_ai_model_usecase_impl.dart';

/// Centraliza os provedores de injeção de dependência do módulo [ai_models].
/// Segue o padrão arquitetural utilizando [RepositoryProvider] do flutter_bloc.
final class AiModelsInjections {
  static List<RepositoryProvider> get repositoryProviders => [
        RepositoryProvider<AiModelDatasource>(
          create: (_) => AiModelDatasourceImpl(dio: Dio()),
        ),
        RepositoryProvider<AiModelRepository>(
          create: (context) => AiModelRepositoryImpl(
            datasource: context.read<AiModelDatasource>(),
          ),
        ),
        RepositoryProvider<DownloadAiModelUsecase>(
          create: (context) => DownloadAiModelUsecaseImpl(
            repository: context.read<AiModelRepository>(),
          ),
        ),
      ];
}
