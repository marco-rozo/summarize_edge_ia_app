part of 'ai_models_cubit.dart';

class AiModelUIState extends Equatable {
  final AiModelEntity modelInfo;
  final bool isDownloaded;
  final double downloadProgress; // 0.0 a 1.0
  final String? filePath;

  const AiModelUIState({
    required this.modelInfo,
    this.isDownloaded = false,
    this.downloadProgress = 0.0,
    this.filePath,
  });

  AiModelUIState copyWith({
    AiModelEntity? modelInfo,
    bool? isDownloaded,
    double? downloadProgress,
    String? filePath,
  }) {
    return AiModelUIState(
      modelInfo: modelInfo ?? this.modelInfo,
      isDownloaded: isDownloaded ?? this.isDownloaded,
      downloadProgress: downloadProgress ?? this.downloadProgress,
      filePath: filePath ?? this.filePath,
    );
  }

  @override
  List<Object?> get props => [modelInfo, isDownloaded, downloadProgress, filePath];
}

sealed class AiModelsState extends Equatable {
  const AiModelsState();

  @override
  List<Object?> get props => [];
}

final class AiModelsInitial extends AiModelsState {
  const AiModelsInitial();
}

final class AiModelsLoading extends AiModelsState {
  const AiModelsLoading();
}

final class AiModelsSuccess extends AiModelsState {
  final List<AiModelUIState> models;
  final Map<AiModelTaskTypeEnum, String> activeModelIds;

  const AiModelsSuccess({
    required this.models,
    this.activeModelIds = const {},
  });

  String? get activeModelId => activeModelIds.values.firstOrNull;

  bool isModelActive(String modelId) => activeModelIds.containsValue(modelId);

  @override
  List<Object?> get props => [models, activeModelIds];
}

final class AiModelsError extends AiModelsState {
  final Failure failure;

  const AiModelsError({required this.failure});

  @override
  List<Object?> get props => [failure];
}
