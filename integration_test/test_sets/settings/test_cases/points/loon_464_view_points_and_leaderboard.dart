import 'package:charlatan/charlatan.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../../../../mocks/firebase_auth_mock.dart';
import '../../../../mocks/google_sign_in_mock.dart';
import '../../../../setup.dart' as app;
import '../../../../test_helpers/post_app_clear.dart';
import '../../../app/flows/login_flow.dart';
import '../../../app_test.dart';

/// [Test case link](https://cesko-digital.atlassian.net/browse/LOON-464)
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    mockGoogleSignIn();
    firebaseAuth = await mockFirebaseAuth();
    charlatan = Charlatan();
  });

  tearDown(() async {
    await postAppClear();
  });

  testWidgets(
    'TC(LOON_464): View Points & Leaderboard',
    (WidgetTester tester) async {
      await app.runMockApp(firebaseAuthOverride: firebaseAuth, charlatan: charlatan);
      await loginFlow(tester: tester, charlatan: charlatan);

      // TODO
    },
    skip: true,
  );
}
