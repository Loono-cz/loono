import 'package:charlatan/charlatan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:loono/ui/screens/logout.dart';
import 'package:loono/ui/screens/settings/open_settings.dart';
import 'package:loono/ui/screens/settings/update_profile.dart';

import '../../../../mocks/firebase_auth_mock.dart';
import '../../../../mocks/google_sign_in_mock.dart';
import '../../../../setup.dart' as app;
import '../../../../test_helpers/post_app_clear.dart';
import '../../../app/flows/login_flow.dart';
import '../../../app_test.dart';
import '../../../prevention/pages/prevention_main_page.dart';
import '../../pages/open_settings_page.dart';
import '../../pages/update_profile_page.dart';

/// [Test case link](https://cesko-digital.atlassian.net/browse/LOON-437)
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

  testWidgets('TC(LOON_437): Logout (straight path)', (WidgetTester tester) async {
    await app.runMockApp(firebaseAuthOverride: firebaseAuth, charlatan: charlatan);
    await loginFlow(tester: tester, charlatan: charlatan);

    final preventionMainPage = PreventionMainPage(tester);
    final openSettingsPage = OpenSettingsPage(tester);
    final updateProfilePage = UpdateProfilePage(tester);

    await preventionMainPage.clickProfileAvatar();
    expect(find.byType(OpenSettingsScreen), findsOneWidget);

    await openSettingsPage.clickEditProfileButton();
    expect(find.byType(UpdateProfileScreen), findsOneWidget);

    await updateProfilePage.clickLogoutButton();
    expect(find.byType(AlertDialog), findsOneWidget);

    await updateProfilePage.confirmLogoutDialog();
    expect(find.byType(UpdateProfileScreen), findsNothing);
    expect(find.byType(LogoutScreen), findsOneWidget);
  });
}
