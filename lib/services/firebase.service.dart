import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:loono/core/app_config.dart';
import 'package:loono/core/app_flavor.dart';

class FirebaseService {
  FirebaseService._({required this.app});

  final FirebaseApp app;

  static Future<FirebaseService> create(AppConfig config) async {
    final app = await Firebase.initializeApp();

    await FirebaseCrashlytics.instance.setCustomKey(
      'env',
      config.flavor.prettyString,
    );

    return FirebaseService._(app: app);
  }

  Future<void> setCrashlyticsCollection({required bool enable}) async {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(enable);
  }
}
