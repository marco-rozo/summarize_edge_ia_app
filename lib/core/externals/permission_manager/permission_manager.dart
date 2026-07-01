import 'package:summary_app/core/externals/permission_manager/enums/permission_manager_status_enum.dart';

abstract class PermissionManager {
  Future<PermissionManagerStatusEnum> requestMicrophonePermission();

  void openAppSettings();
}
