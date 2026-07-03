import 'package:summary_app/core/utils/typedefs.dart';
import 'package:summary_app/modules/ai_models/features/domain/entities/ai_model_entity.dart';

abstract class GetAllAiModelsUsecase {
  Future<Output<List<AiModelEntity>>> call();
}
