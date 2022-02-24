import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:loono/services/auth/auth_service.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/utils/registry.dart';

Future<void> appClear() async {
  await registry.get<AuthService>().signOut();
  await registry.get<DatabaseService>().clearDb();
  // clears saved user avatar and other app's temp data
  await registry.get<DefaultCacheManager>().emptyCache();
  // TODO: Calling this after adding the firebase_messaging package in order to delete a fcm token
  // FirebaseMessaging.instance.deleteToken()
}
