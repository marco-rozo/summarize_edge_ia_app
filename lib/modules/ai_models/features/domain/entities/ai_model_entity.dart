import 'package:equatable/equatable.dart';
import 'package:summary_app/modules/ai_models/features/domain/enums/ai_model_task_type_enum.dart';

class AiModelEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final String downloadUrl;
  final String fileName;
  final int sizeInBytes;
  final String parameterCount;
  final String taskType;
  final String version;
  final bool isActive;

  const AiModelEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.downloadUrl,
    required this.fileName,
    required this.sizeInBytes,
    required this.parameterCount,
    required this.taskType,
    required this.version,
    this.isActive = true,
  });

  String get formattedSize {
    if (sizeInBytes <= 0) return '0.0 MB';
    final mb = sizeInBytes / (1024 * 1024);
    if (mb >= 1024) {
      final gb = mb / 1024;
      return '${gb.toStringAsFixed(1)} GB';
    }
    return '${mb.toStringAsFixed(1)} MB';
  }

  String get formattedSizeInRam {
    if (sizeInBytes <= 0) return '0.0 MB RAM';
    final mb = sizeInBytes / (1024 * 1024);
    if (mb >= 1024) {
      final gb = mb / 1024;
      return '~${gb.toStringAsFixed(1)} GB RAM';
    }
    return '~${mb.toStringAsFixed(1)} MB RAM';
  }

  AiModelTaskTypeEnum get taskTypeEnum =>
      AiModelTaskTypeEnum.fromValue(taskType);

  String get formattedArchitecture => taskTypeEnum.architectureLabel;

  String get taskTypeLabel => taskTypeEnum.label;

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    downloadUrl,
    fileName,
    sizeInBytes,
    parameterCount,
    taskType,
    version,
    isActive,
  ];
}
