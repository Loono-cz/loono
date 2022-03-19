import 'package:charlatan/charlatan.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:loono/ui/screens/logout.dart';
import 'package:loono/ui/screens/settings/open_settings.dart';
import 'package:loono/ui/screens/settings/update_profile.dart';

import '../../../../setup.dart' as app;
import '../../../app/flows/login_flow.dart';
import '../../../prevention/pages/prevention_main_page.dart';
import '../../pages/open_settings_page.dart';
import '../../pages/update_profile/update_profile_page.dart';

/// [Test case link](https://cesko-digital.atlassian.net/browse/LOON-437)
Future<void> run({
  required WidgetTester tester,
  required Charlatan charlatan,
  required FirebaseAuth firebaseAuth,
}) async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

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
}
