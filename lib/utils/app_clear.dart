import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:loono/services/auth/auth_service.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/firebase_storage_service.dart';
import 'package:loono/services/notification_service.dart';
import 'package:loono/services/secure_storage_service.dart';
import 'package:loono/utils/registry.dart';

Future<void> appClear({bool deletingAccount = false}) async {
  if (deletingAccount) {
    try {
      await registry.get<FirebaseStorageService>().deleteAll();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  await registry.get<AuthService>().signOut();
  await registry.get<DatabaseService>().clearDb();
  await registry.get<SecureStorageService>().deleteAll();
  await registry.get<NotificationService>().removeUserId();

  // clears saved user avatar and other app's temp data
  await registry.get<DefaultCacheManager>().emptyCache();
}
