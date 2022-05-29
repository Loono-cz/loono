import 'package:charlatan/charlatan.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../../../../setup.dart' as app;
import '../../../../test_helpers/widget_tester_extensions.dart';
import '../../../app/flows/login_flow.dart';
import '../../../app/pages/login_page.dart';

/// [Test case link](https://cesko-digital.atlassian.net/browse/LOON-671)
Future<void> run({
  required WidgetTester tester,
  required Charlatan charlatan,
}) async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final loginPage = LoginPage(tester);

  await app.runMockApp(charlatan: charlatan);
  await loginFlow(
    tester: tester,
    charlatan: charlatan,
    examinationsResponse: (_) => CharlatanHttpResponse(statusCode: 500),
  );

  // Server is down, an error message is shown to the user and user stays on the same (Login) page.
  const errorMsg = 'naše systémy mají preventivní prohlídku';
  await tester.waitForToastToDisappear(msgPattern: errorMsg);
  await loginPage.verifyScreenIsShown();
}
