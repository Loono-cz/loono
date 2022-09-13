import 'package:loono/services/database_service.dart';
import 'package:loono/services/secure_storage_service.dart';
import 'package:loono/utils/app_clear.dart';
import 'package:loono/utils/registry.dart';

import '../mocks/firebase_auth_mock.dart';
import '../mocks/google_sign_in_mock.dart';

Future<void> postAppClear() async {
  await mockFirebaseAuth();
  mockGoogleSignIn();
  await appClear();
  await registry.get<DatabaseService>().closeDb();
  await registry.get<SecureStorageService>().deleteDonateInfoData();
  await registry.reset();
  tearDownFirebaseAuth();
  tearDownGoogleSignIn();
}
