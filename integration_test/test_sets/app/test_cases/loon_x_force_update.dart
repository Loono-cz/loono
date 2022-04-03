import 'package:charlatan/charlatan.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:loono/utils/registry.dart';

import '../../../setup.dart' as app;
import '../flows/login_flow.dart';
import '../pages/force_update_page.dart';

/// [Test case link](https://cesko-digital.atlassian.net/browse/LOON-580)
Future<void> run({
  required WidgetTester tester,
  required Charlatan charlatan,
  required FirebaseAuth firebaseAuth,
}) async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  await app.runMockApp(firebaseAuthOverride: firebaseAuth, charlatan: charlatan);
  await loginFlow(
    tester: tester,
    charlatan: charlatan,
    accountResponse: (_) => CharlatanHttpResponse(statusCode: FORCE_UPDATE_STATUS_CODE),
  );

  final forceUpdatePage = ForceUpdatePage(tester);

  await forceUpdatePage.verifyScreenIsShown();
  // SVG image is not fully supported, this silences the assertion error
  expect(
    tester.takeException().toString(),
    contains('This library only supports <defs> and xlink:href references'),
  );
  forceUpdatePage.verifyForceUpdateButtonIsShown();
}
