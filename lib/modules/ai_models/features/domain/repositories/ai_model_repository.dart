import 'package:summary_app/core/utils/typedefs.dart';
import 'package:summary_app/modules/ai_models/features/domain/entities/ai_model_entity.dart';

abstract class AiModelRepository {
  Future<Output<List<AiModelEntity>>> getAllModels();

  Future<Output<String>> downloadModel({
    required String url,
    required String filePath,
    void Function(int received, int total)? onProgress,
  });
}

typedef IAiModelRepository = AiModelRepository;
