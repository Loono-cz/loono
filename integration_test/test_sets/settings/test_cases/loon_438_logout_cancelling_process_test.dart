import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:loono/ui/screens/settings/open_settings.dart';
import 'package:loono/ui/screens/settings/update_profile.dart';

import '../../../mocks/firebase_auth_mock.dart';
import '../../../mocks/google_sign_in_mock.dart';
import '../../../setup.dart' as app;
import '../../app/flows/login_flow.dart';
import '../../prevention/pages/prevention_main_page.dart';
import '../pages/open_settings_page.dart';
import '../pages/update_profile_page.dart';

/// [Test case link](https://cesko-digital.atlassian.net/browse/LOON-438)
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Settings', () {
    late final FirebaseAuth firebaseAuth;

    setUp(() async {
      mockGoogleSignIn();
      firebaseAuth = await mockFirebaseAuth();
    });

    testWidgets('TC(LOON_438): Logout (canceling process)', (WidgetTester tester) async {
      await app.runMockApp(firebaseAuthOverride: firebaseAuth);
      await loginFlow(tester: tester);

      final preventionMainPage = PreventionMainPage(tester);
      final openSettingsPage = OpenSettingsPage(tester);
      final updateProfilePage = UpdateProfilePage(tester);

      await preventionMainPage.clickProfileAvatar();
      expect(find.byType(OpenSettingsScreen), findsOneWidget);

      await openSettingsPage.clickEditProfileButton();
      expect(find.byType(UpdateProfileScreen), findsOneWidget);

      await updateProfilePage.clickLogoutButton();
      expect(find.byType(AlertDialog), findsOneWidget);

      await updateProfilePage.cancelLogoutDialog();
      expect(find.byType(UpdateProfileScreen), findsOneWidget);
      expect(find.text('Tvůj účet'), findsOneWidget);
    });
  });
}
