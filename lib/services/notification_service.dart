import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:loono/helpers/examination_extensions.dart';
import 'package:loono/models/categorized_examination.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/api_service.dart';

import 'package:loono/utils/app_config.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

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
      final notificationExaminationType = res.notification.additionalData?.entries
          .singleWhereOrNull((element) => element.key == 'examinationType')
          ?.value
          .toString();
      await registry.get<ApiService>().getExaminations().then((res) {
        res.map(
          success: (exams) {
            final examinationToOpen = exams.data.examinations.firstWhereOrNull(
              (element) => element.examinationType.toString() == notificationExaminationType,
            );
            if (examinationToOpen != null) {
              registry.get<AppRouter>().push(
                    ExaminationDetailRoute(
                      categorizedExamination: CategorizedExamination(
                        examination: examinationToOpen,
                        category: examinationToOpen.calculateStatus(),
                      ),
                    ),
                  );
              return;
            }

            final selfExaminationToOpen = exams.data.selfexaminations.firstWhereOrNull(
              (element) => element.type.toString() == notificationExaminationType,
            );
            if (selfExaminationToOpen != null) {
              registry.get<AppRouter>().push(
                    SelfExaminationDetailRoute(
                      sex: selfExaminationToOpen.type == SelfExaminationType.TESTICULAR
                          ? Sex.MALE
                          : Sex.FEMALE,
                      selfExamination: selfExaminationToOpen,
                    ),
                  );
              return;
            }
            log('Failed to recognize examination from notification');
          },
          failure: (err) {
            log('Unable to fetch examination data for notifications');
          },
        );
      });
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
