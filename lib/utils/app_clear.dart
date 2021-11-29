import 'package:loono/services/database_service.dart';
import 'package:loono/utils/registry.dart';

Future<void> clearAllData() async {
  await registry.get<DatabaseService>().clearDb();
  // TODO: Calling this after adding the firebase_messaging package in order to delete a fcm token
  // FirebaseMessaging.instance.deleteToken()
}
