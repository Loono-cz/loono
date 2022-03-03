import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../../../mocks/firebase_auth_mock.dart';
import '../../../mocks/google_sign_in_mock.dart';
import '../../../setup.dart' as app;
import '../flows/login_flow.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group(
    'E2E: full app flows',
    () {
      late final FirebaseAuth firebaseAuth;

      setUp(() async {
        mockGoogleSignIn();
        firebaseAuth = await mockFirebaseAuth();
      });

      testWidgets('login flow', (WidgetTester tester) async {
        await app.runMockApp(firebaseAuthOverride: firebaseAuth);
        await loginFlow(tester: tester);
        await tester.pumpAndSettle();
      });
    },
    skip: true,
  );
}
