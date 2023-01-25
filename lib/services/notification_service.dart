import 'dart:async';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:loono/repositories/user_repository.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/router/notification_router.dart';
import 'package:loono/utils/app_config.dart';
import 'package:loono/utils/registry.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  NotificationService();

  final _permissionController = StreamController<OSNotificationPermission>.broadcast();

  Future<void> init() async {
    await OneSignal.shared.setLogLevel(OSLogLevel.info, OSLogLevel.none);
    final appId = getEnvString(
      dotenv.env,
      registry.get<AppConfig>().flavor == AppFlavors.dev
          ? 'ONESIGNAL_APP_ID_DEV'
          : 'ONESIGNAL_APP_ID_PROD',
    );
    await OneSignal.shared.setAppId(appId);
    OneSignal.shared.setPermissionObserver(_onPermissionStateChanges);
    OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult res) async {
      final notificationRouter =
          NotificationRouter.fromNotificationData(res.notification.additionalData);
      while (!isRegistryInitialized) {
        await Future<void>.delayed(const Duration(milliseconds: 100));
      }
      await notificationRouter.navigate();
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

  Future<void> enableNotifications(bool enabled) async {
    await OneSignal.shared.disablePush(!enabled);
  }

  Future<void> requestNotificationPermission({bool fromOnboarding = false}) async {
    final shouldDisplayNotificationScreen = await _shouldAskForNotification();
    final globalRouter = registry.get<AppRouter>();

    switch (fromOnboarding) {
      case true:
        final preAuthMainRoute = PreAuthMainRoute();
        if (shouldDisplayNotificationScreen) {
          await globalRouter.pushAll([
            preAuthMainRoute,
            AllowNotificationsRoute(
              onSkipTap: () => globalRouter.push(preAuthMainRoute),
              onContinueTap: () async {
                await registry.get<NotificationService>().promptPermissions();
                await globalRouter.push(preAuthMainRoute);
              },
            ),
          ]);
        } else {
          await globalRouter.push(preAuthMainRoute);
        }
        break;
      case false:
        if (shouldDisplayNotificationScreen) {
          await globalRouter.push(
            AllowNotificationsRoute(
              onSkipTap: globalRouter.pop,
              onContinueTap: () async {
                await registry.get<NotificationService>().promptPermissions();
                await globalRouter.pop();
              },
            ),
          );
        }
        break;
    }
  }

  Future<bool> _shouldAskForNotification() async {
    final userRepository = registry.get<UserRepository>();
    final permissionRequested = await userRepository.requestedNotificationPermission();
    if (!Platform.isIOS) return false;
    final permissionStatus = await Permission.notification.status;
    if (permissionStatus.isGranted) return false;
    if (!permissionRequested) return true;
    return false;
  }
}
