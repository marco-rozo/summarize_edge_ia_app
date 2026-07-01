import 'package:permission_handler/permission_handler.dart'
    as permission_handler;
import 'package:summary_app/core/externals/permission_manager/enums/permission_manager_status_enum.dart';
import 'package:summary_app/core/externals/permission_manager/mixins/permission_manager_mixin.dart';
import 'package:summary_app/core/externals/permission_manager/permission_manager.dart';

class PermissionManagerImpl
    with PermissionManagerMixin
    implements PermissionManager {
  @override
  Future<PermissionManagerStatusEnum> requestMicrophonePermission() async {
    final permission =
        await permission_handler.Permission.microphone.request();

    return convertPermissionStatus(permission);
  }

  @override
  void openAppSettings() => permission_handler.openAppSettings();
}
