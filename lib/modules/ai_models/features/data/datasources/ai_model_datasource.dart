import 'package:summary_app/modules/ai_models/features/data/models/ai_model_model.dart';

abstract class AiModelDatasource {
  Future<List<AiModelModel>> getAllModels();

  Future<String> downloadModel({
    required String url,
    required String filePath,
    void Function(int received, int total)? onProgress,
  });
}

typedef IAiModelDatasource = AiModelDatasource;
