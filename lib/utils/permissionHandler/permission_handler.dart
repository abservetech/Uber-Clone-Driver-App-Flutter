import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

import '../utils.dart';

class PermissionHandler {
  PermissionHandler._();

  static late PermissionHandler _instance;

  static PermissionHandler getInstance() {
    _instance = PermissionHandler._();
    return _instance;
  }

  final List<Permission> permissions = [
    Permission.location,
    // Permission.camera,
    // Permission.storage,
  ];


  Future<dynamic> validateAllPermissions() async {
    bool validateAllPermissionsGranted = true;
    for (final Permission perm in permissions) {
      if (await perm.isGranted == false) validateAllPermissionsGranted = false;
    }
    if (validateAllPermissionsGranted) {
      return AppConstant.isPermissionGranted = true;
    } else {
      return AppConstant.isPermissionGranted = false;
    }
  }

  //check all the permissions are validate
  Future<bool> checkPermissions() async {
    bool requestAllPermissionsGranted = true;
    for (final Permission perm in permissions) {
      final PermissionStatus status = await perm.request();
      if (status == PermissionStatus.permanentlyDenied ||
          status == PermissionStatus.denied) {
        requestAllPermissionsGranted = false;
      }
    }
    Logger.appLogs('permissionGranted:: $requestAllPermissionsGranted');
    return requestAllPermissionsGranted;
  }
}
