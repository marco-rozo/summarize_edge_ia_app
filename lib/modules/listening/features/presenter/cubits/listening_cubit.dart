import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:summary_app/core/externals/permission_manager/enums/permission_manager_status_enum.dart';
import 'package:summary_app/core/externals/permission_manager/permission_manager.dart';

part 'listening_state.dart';

class ListeningCubit extends Cubit<ListeningState> {
  final PermissionManager _permissionManager;
  final Logger _logger;

  ListeningCubit({
    required PermissionManager permissionManager,
    required Logger logger,
  })  : _permissionManager = permissionManager,
        _logger = logger,
        super(const ListeningInitial());

  Future<void> checkMicrophonePermission() async {
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

    emit(const ListeningReady());
  }

  void openSettings() => _permissionManager.openAppSettings();

  void reset() => emit(const ListeningInitial());

  void summaryWithIaModel([String? audioPath]) {
    _logger.i('Resumir com IA -> Áudio: ${audioPath ?? "N/A"}');
  }
}
