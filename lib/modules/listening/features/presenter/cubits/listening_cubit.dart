import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:summary_app/core/errors/failure.dart';
import 'package:summary_app/core/externals/permission_manager/enums/permission_manager_status_enum.dart';
import 'package:summary_app/core/externals/permission_manager/permission_manager.dart';
import 'package:summary_app/core/externals/speech_recognizer/speech_recognizer.dart';

part 'listening_state.dart';

class ListeningCubit extends Cubit<ListeningState> {
  final SpeechRecognizer _speechRecognizer;
  final PermissionManager _permissionManager;
  final Logger _logger;

  ListeningCubit({
    required SpeechRecognizer speechRecognizer,
    required PermissionManager permissionManager,
    required Logger logger,
  })  : _speechRecognizer = speechRecognizer,
        _permissionManager = permissionManager,
        _logger = logger,
        super(const ListeningInitial());

  void init() {
    _logger.i('init');
    _speechRecognizer.initialize(
      onStatus: (status) {
        _logger.i('Speech recognizer status: $status');
        if ((status == 'notListening' || status == 'done') &&
            state is ListeningInProgress &&
            !isClosed) {
          final currentText = (state as ListeningInProgress).recognizedText;
          emit(ListeningPaused(recognizedText: currentText));
        }
      },
      onError: (error) {
        _logger.e('Speech recognizer error', error: error);
        if (state is ListeningInProgress && !isClosed) {
           final currentText = (state as ListeningInProgress).recognizedText;
           emit(ListeningPaused(recognizedText: currentText));
        }
      },
    );
  }

  Future<void> toggleListening() async {
    if (state is ListeningInProgress) {
      await _stopListening();
    } else {
      await _startListening();
    }
  }

  Future<void> _startListening() async {
    final permissionStatus =
        await _permissionManager.requestMicrophonePermission();

    if (permissionStatus == PermissionManagerStatusEnum.permanentlyDenied) {
      emit(const ListeningPermissionDenied(isPermanent: true));
      return;
    }

    if (permissionStatus != PermissionManagerStatusEnum.granted &&
        permissionStatus != PermissionManagerStatusEnum.limited) {
      emit(const ListeningPermissionDenied(isPermanent: false));
      return;
    }

    final currentText = state is ListeningPaused
        ? (state as ListeningPaused).recognizedText
        : '';

    emit(ListeningInProgress(
      recognizedText: currentText,
      fullPreviousText: currentText,
    ));

    try {
      await _speechRecognizer.startListening(
        onResult: (recognizedText, isFinal) {
          if (!isClosed) {
            final currentState = state;
            if (currentState is! ListeningInProgress) return;

            final previousText = currentState.fullPreviousText;

            final newFullText = previousText.isEmpty
                ? recognizedText
                : '$previousText $recognizedText'.trim();

            emit(
              ListeningInProgress(
                recognizedText: newFullText,
                fullPreviousText: previousText,
              ),
            );
          }
        },
      );
    } catch (e, stackTrace) {
      _logger.e('Error starting listening', error: e, stackTrace: stackTrace);
      emit(ListeningError(
        failure: UnknownFailure(
          errorMessage: e.toString(),
          stackTrace: stackTrace,
        ),
      ));
    }
  }

  Future<void> _stopListening() async {
    final currentText = state is ListeningInProgress
        ? (state as ListeningInProgress).recognizedText
        : '';

    try {
      await _speechRecognizer.stopListening();
      emit(ListeningPaused(recognizedText: currentText));
    } catch (e, stackTrace) {
      _logger.e('Error stopping listening', error: e, stackTrace: stackTrace);
      emit(ListeningError(
        failure: UnknownFailure(
          errorMessage: e.toString(),
          stackTrace: stackTrace,
        ),
      ));
    }
  }

  void openSettings() => _permissionManager.openAppSettings();

  void reset() => emit(const ListeningInitial());
}
