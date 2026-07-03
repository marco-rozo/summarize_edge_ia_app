import 'package:summary_app/modules/ai_models/features/domain/entities/ai_model_entity.dart';

class AiModelModel extends AiModelEntity {
  const AiModelModel({
    required super.id,
    required super.name,
    required super.description,
    required super.downloadUrl,
    required super.fileName,
    required super.sizeInBytes,
    required super.parameterCount,
    required super.taskType,
    required super.version,
    super.isActive = true,
  });

  factory AiModelModel.fromMap(Map<String, dynamic> map, String documentId) {
    return AiModelModel(
      id: documentId,
      name: map['name'] as String? ?? '',
      description: map['description'] as String? ?? '',
      downloadUrl: map['downloadUrl'] as String? ?? '',
      fileName: map['fileName'] as String? ?? '',
      sizeInBytes: (map['sizeInBytes'] as num?)?.toInt() ?? 0,
      parameterCount: map['parameterCount'] as String? ?? '',
      taskType: map['taskType'] as String? ?? '',
      version: map['version'] as String? ?? '',
      isActive: map['isActive'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'downloadUrl': downloadUrl,
      'fileName': fileName,
      'sizeInBytes': sizeInBytes,
      'parameterCount': parameterCount,
      'taskType': taskType,
      'version': version,
      'isActive': isActive,
    };
  }
}
