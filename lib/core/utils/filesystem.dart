import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:selene/core/utils/platform.dart';

Future<Permission> getPermission(BuildContext context) async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (context.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    if (androidInfo.version.sdkInt >= 33) {
      return Permission.manageExternalStorage;
    }
  }
  return Permission.storage;
}
