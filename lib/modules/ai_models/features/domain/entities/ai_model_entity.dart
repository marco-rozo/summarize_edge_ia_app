import 'package:equatable/equatable.dart';

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

  String get formattedArchitecture {
    if (taskType.toLowerCase().contains('audio') ||
        taskType.toLowerCase() == 'asr') {
      return 'ASR Acústico';
    }
    return 'Transformer / LLM';
  }

  String get taskTypeLabel {
    if (taskType.toLowerCase().contains('audio') ||
        taskType.toLowerCase() == 'asr') {
      return 'ASR (Reconhecimento Automático de Fala)';
    }
    return 'Veloz / Instrução';
  }

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
