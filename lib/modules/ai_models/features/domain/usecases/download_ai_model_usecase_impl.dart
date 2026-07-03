// ignore_for_file: prefer_initializing_formals
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:path_provider/path_provider.dart';
import 'package:summary_app/core/utils/typedefs.dart';
import 'package:summary_app/modules/ai_models/core/errors/download_model_failure.dart';
import 'package:summary_app/modules/ai_models/features/domain/repositories/ai_model_repository.dart';
import 'package:summary_app/modules/ai_models/features/domain/usecases/download_ai_model_usecase.dart';

class DownloadAiModelUsecaseImpl implements DownloadAiModelUsecase {
  final AiModelRepository _repository;

  const DownloadAiModelUsecaseImpl({required AiModelRepository repository})
    : _repository = repository;

  @override
  Future<Output<String>> call({
    required String url,
    required String fileName,
  }) async {
    try {
      final directory = await getApplicationSupportDirectory();
      final filePath = '${directory.path}/$fileName';

      final file = File(filePath);
      if (!await file.parent.exists()) {
        await file.parent.create(recursive: true);
      }

      return await _repository.downloadModel(url: url, filePath: filePath);
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
