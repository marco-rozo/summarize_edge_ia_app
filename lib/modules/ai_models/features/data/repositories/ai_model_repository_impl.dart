// ignore_for_file: prefer_initializing_formals
import 'package:dartz/dartz.dart';
import 'package:summary_app/core/utils/typedefs.dart';
import 'package:summary_app/modules/ai_models/core/errors/download_model_failure.dart';
import 'package:summary_app/modules/ai_models/core/errors/get_all_models_failure.dart';
import 'package:summary_app/modules/ai_models/features/data/datasources/ai_model_datasource.dart';
import 'package:summary_app/modules/ai_models/features/domain/entities/ai_model_entity.dart';
import 'package:summary_app/modules/ai_models/features/domain/repositories/ai_model_repository.dart';

class AiModelRepositoryImpl implements AiModelRepository {
  final AiModelDatasource _datasource;

  AiModelRepositoryImpl({required AiModelDatasource datasource})
    : _datasource = datasource;

  @override
  Future<Output<List<AiModelEntity>>> getAllModels() async {
    try {
      final models = await _datasource.getAllModels();
      return Right(models);
    } catch (e, stackTrace) {
      return Left(
        GetAllModelsFailure(
          errorMessage: e.toString(),
          stackTrace: stackTrace,
        ),
      );
    }
  }

  @override
  Future<Output<String>> downloadModel({
    required String url,
    required String filePath,
    void Function(int received, int total)? onProgress,
  }) async {
    try {
      final path = await _datasource.downloadModel(
        url: url,
        filePath: filePath,
        onProgress: onProgress,
      );
      return Right(path);
    } catch (e, stackTrace) {
      return Left(
        DownloadModelFailure(
          errorMessage: e.toString(),
          stackTrace: stackTrace,
        ),
      );
    }
  }
}
