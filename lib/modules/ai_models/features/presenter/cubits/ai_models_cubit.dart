// ignore_for_file: prefer_initializing_formals
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:summary_app/core/errors/failure.dart';
import 'package:summary_app/modules/ai_models/features/domain/entities/ai_model_entity.dart';
import 'package:summary_app/modules/ai_models/features/domain/usecases/download_ai_model_usecase.dart';
import 'package:summary_app/modules/ai_models/features/domain/usecases/get_all_ai_models_usecase.dart';

part 'ai_models_state.dart';

class AiModelsCubit extends Cubit<AiModelsState> {
  final GetAllAiModelsUsecase _getAllAiModelsUsecase;
  final DownloadAiModelUsecase _downloadAiModelUsecase;
  final Logger _logger;

  AiModelsCubit({
    required GetAllAiModelsUsecase getAllAiModelsUsecase,
    required DownloadAiModelUsecase downloadAiModelUsecase,
    Logger? logger,
  })  : _getAllAiModelsUsecase = getAllAiModelsUsecase,
        _downloadAiModelUsecase = downloadAiModelUsecase,
        _logger = logger ?? Logger(),
        super(const AiModelsInitial());

  Future<void> fetchModels() async {
    emit(const AiModelsLoading());
    final result = await _getAllAiModelsUsecase();

    await result.fold(
      (failure) async {
        _logger.e('Erro ao buscar modelos de IA', error: failure.errorMessage);
        emit(AiModelsError(failure: failure));
      },
      (entities) async {
        try {
          final directory = await getApplicationSupportDirectory();
          final List<AiModelUIState> uiStates = [];

          for (final entity in entities) {
            final filePath = '${directory.path}/${entity.fileName}';
            final file = File(filePath);
            final exists = await file.exists();

            uiStates.add(
              AiModelUIState(
                modelInfo: entity,
                isDownloaded: exists,
                downloadProgress: exists ? 1.0 : 0.0,
                filePath: exists ? filePath : null,
              ),
            );
          }

          final defaultActiveId = uiStates
              .where((m) => m.isDownloaded)
              .firstOrNull
              ?.modelInfo
              .id ??
              uiStates.firstOrNull?.modelInfo.id;

          emit(AiModelsSuccess(models: uiStates, activeModelId: defaultActiveId));
        } catch (e, stackTrace) {
          _logger.e('Erro ao verificar arquivos locais', error: e, stackTrace: stackTrace);
          emit(AiModelsError(
            failure: UnknownFailure(
              errorMessage: e.toString(),
              stackTrace: stackTrace,
            ),
          ));
        }
      },
    );
  }

  Future<void> downloadModel(AiModelUIState uiState) async {
    if (state is! AiModelsSuccess) return;
    if (uiState.isDownloaded || (uiState.downloadProgress > 0.0 && uiState.downloadProgress < 1.0)) return;

    final currentList = (state as AiModelsSuccess).models;
    final index = currentList.indexWhere((item) => item.modelInfo.id == uiState.modelInfo.id);
    if (index == -1) return;

    final currentState = state as AiModelsSuccess;
    // Inicia progresso em 1% (0.01) para acionar o estado visual do CircularProgressIndicator
    final initialList = List<AiModelUIState>.from(currentState.models);
    initialList[index] = uiState.copyWith(downloadProgress: 0.01);
    emit(AiModelsSuccess(models: initialList, activeModelId: currentState.activeModelId));

    final result = await _downloadAiModelUsecase(
      url: uiState.modelInfo.downloadUrl,
      fileName: uiState.modelInfo.fileName,
      onProgress: (received, total) {
        if (isClosed || state is! AiModelsSuccess) return;
        if (total != -1 && total > 0) {
          double progress = received / total;
          if (progress < 0.01) progress = 0.01;
          if (progress > 0.99) progress = 0.99;

          final currentState = state as AiModelsSuccess;
          final idx = currentState.models.indexWhere((item) => item.modelInfo.id == uiState.modelInfo.id);
          if (idx != -1) {
            final updatedList = List<AiModelUIState>.from(currentState.models);
            updatedList[idx] = updatedList[idx].copyWith(downloadProgress: progress);
            emit(AiModelsSuccess(models: updatedList, activeModelId: currentState.activeModelId));
          }
        }
      },
    );

    if (isClosed) return;

    result.fold(
      (failure) {
        _logger.e('Erro ao baixar modelo ${uiState.modelInfo.name}', error: failure.errorMessage);
        if (state is AiModelsSuccess) {
          final currentState = state as AiModelsSuccess;
          final idx = currentState.models.indexWhere((item) => item.modelInfo.id == uiState.modelInfo.id);
          if (idx != -1) {
            final updatedList = List<AiModelUIState>.from(currentState.models);
            updatedList[idx] = updatedList[idx].copyWith(downloadProgress: 0.0, isDownloaded: false);
            emit(AiModelsSuccess(models: updatedList, activeModelId: currentState.activeModelId));
          }
        }
      },
      (filePath) {
        if (state is AiModelsSuccess) {
          final currentState = state as AiModelsSuccess;
          final idx = currentState.models.indexWhere((item) => item.modelInfo.id == uiState.modelInfo.id);
          if (idx != -1) {
            final updatedList = List<AiModelUIState>.from(currentState.models);
            updatedList[idx] = updatedList[idx].copyWith(
              isDownloaded: true,
              downloadProgress: 1.0,
              filePath: filePath,
            );
            final newActiveId = currentState.activeModelId ?? uiState.modelInfo.id;
            emit(AiModelsSuccess(models: updatedList, activeModelId: newActiveId));
          }
        }
      },
    );
  }

  Future<void> deleteModel(AiModelUIState uiState) async {
    if (state is! AiModelsSuccess || !uiState.isDownloaded || uiState.filePath == null) return;

    try {
      final file = File(uiState.filePath!);
      if (await file.exists()) {
        await file.delete();
        _logger.i('Modelo removido: ${uiState.filePath}');
      }

      final currentList = (state as AiModelsSuccess).models;
      final currentActiveId = (state as AiModelsSuccess).activeModelId;
      final updatedList = currentList.map((item) {
        if (item.modelInfo.id == uiState.modelInfo.id) {
          return item.copyWith(
            isDownloaded: false,
            downloadProgress: 0.0,
            filePath: null,
          );
        }
        return item;
      }).toList();

      final newActiveId = (currentActiveId == uiState.modelInfo.id)
          ? updatedList.where((m) => m.isDownloaded).firstOrNull?.modelInfo.id
          : currentActiveId;

      emit(AiModelsSuccess(models: updatedList, activeModelId: newActiveId));
    } catch (e, stackTrace) {
      _logger.e('Erro ao deletar modelo', error: e, stackTrace: stackTrace);
    }
  }

  void selectModel(String modelId) {
    if (state is! AiModelsSuccess) return;
    final currentState = state as AiModelsSuccess;
    emit(AiModelsSuccess(
      models: currentState.models,
      activeModelId: modelId,
    ));
  }
}
