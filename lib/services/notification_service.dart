import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:loono/utils/app_config.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class NotificationService {
  NotificationService() {
    _init();
  }

  Future<void> _init() async {
    OneSignal.shared.setLogLevel(OSLogLevel.none, OSLogLevel.none);

    final appId = getEnvString(dotenv.env, 'ONESIGNAL_APP_ID');
    OneSignal.shared.setAppId(appId);
  }
}
