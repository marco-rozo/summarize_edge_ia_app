import 'package:permission_handler/permission_handler.dart';
import 'package:summary_app/core/externals/permission_manager/enums/permission_manager_status_enum.dart';

mixin PermissionManagerMixin {
  PermissionManagerStatusEnum convertPermissionStatus(
      PermissionStatus permissionStatus) {
    return switch (permissionStatus) {
      PermissionStatus.denied => PermissionManagerStatusEnum.denied,
      PermissionStatus.granted => PermissionManagerStatusEnum.granted,
      PermissionStatus.limited => PermissionManagerStatusEnum.limited,
      PermissionStatus.permanentlyDenied =>
        PermissionManagerStatusEnum.permanentlyDenied,
      PermissionStatus.provisional => PermissionManagerStatusEnum.provisional,
      PermissionStatus.restricted => PermissionManagerStatusEnum.restricted,
    };
  }
}
