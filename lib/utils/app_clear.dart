import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:loono/services/auth/auth_service.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/notification_service.dart';
import 'package:loono/services/secure_storage_service.dart';
import 'package:loono/utils/registry.dart';

Future<void> appClear({bool deletingAccount = false}) async {
  await registry.get<AuthService>().signOut();
  await registry.get<DatabaseService>().clearDb();
  await registry.get<SecureStorageService>().deleteAll();

  // clears saved user avatar and other app's temp data
  await registry.get<DefaultCacheManager>().emptyCache();

  if (deletingAccount) {
    await registry.get<NotificationService>().removeId();
  }
}
