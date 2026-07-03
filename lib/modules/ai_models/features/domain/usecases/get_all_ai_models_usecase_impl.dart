// ignore_for_file: prefer_initializing_formals
import 'package:summary_app/core/utils/typedefs.dart';
import 'package:summary_app/modules/ai_models/features/domain/entities/ai_model_entity.dart';
import 'package:summary_app/modules/ai_models/features/domain/repositories/ai_model_repository.dart';
import 'package:summary_app/modules/ai_models/features/domain/usecases/get_all_ai_models_usecase.dart';

class GetAllAiModelsUsecaseImpl implements GetAllAiModelsUsecase {
  final AiModelRepository _repository;

  const GetAllAiModelsUsecaseImpl({required AiModelRepository repository})
    : _repository = repository;

  @override
  Future<Output<List<AiModelEntity>>> call() => _repository.getAllModels();
}
