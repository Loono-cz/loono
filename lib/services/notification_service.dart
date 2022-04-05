import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:loono/utils/app_config.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class NotificationService {
  NotificationService();

  final _permissionController = StreamController<OSNotificationPermission>.broadcast();

  Future<void> init() async {
    await OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    final appId = getEnvString(dotenv.env, 'ONESIGNAL_APP_ID');
    await OneSignal.shared.setAppId(appId);
    OneSignal.shared.setPermissionObserver(_onPermissionStateChanges);
    OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult res) {
      /// TODO: handle notification action
      log(res.notification.toString());
    });
  }

  Future<void> setUserId(String userId) async {
    await OneSignal.shared.setExternalUserId(userId);
  }

  Future<void> removeUserId() async {
    await OneSignal.shared.removeExternalUserId();
  }

  /// Watch notification permission state. Useful only on iOS.
  Stream<OSNotificationPermission> subscribePermissionState() {
    return _permissionController.stream.distinct();
  }

  /// Useful only on iOS. Does nothing on Android.
  ///
  /// Returns `true` if notifications permissions are granted.
  Future<bool> promptPermissions() async {
    if (Platform.isAndroid) {
      return true;
    }
    return OneSignal.shared.promptUserForPushNotificationPermission();
  }

  /// Get OneSignal User ID/Token for current user.
  Future<String?> getUserToken() async {
    final state = await OneSignal.shared.getDeviceState();
    return state?.userId;
  }

  Future<void> _onPermissionStateChanges(OSPermissionStateChanges changes) async {
    if (changes.to.status != null) {
      _permissionController.add(changes.to.status!);
    }
  }
}
