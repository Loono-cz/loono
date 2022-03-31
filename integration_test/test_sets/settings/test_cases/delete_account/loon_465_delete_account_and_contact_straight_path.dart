import 'package:charlatan/charlatan.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:loono/ui/screens/settings/after_deletion.dart';
import 'package:loono/ui/screens/settings/delete_account.dart';
import 'package:loono/ui/screens/settings/open_settings.dart';
import 'package:loono/ui/screens/settings/update_profile.dart';

import '../../../../setup.dart' as app;
import '../../../app/flows/login_flow.dart';
import '../../../prevention/pages/prevention_main_page.dart';
import '../../pages/open_settings_page.dart';
import '../../pages/update_profile/delete_account_page.dart';
import '../../pages/update_profile/update_profile_page.dart';

/// [Test case link](https://cesko-digital.atlassian.net/browse/LOON-465)
Future<void> run({
  required WidgetTester tester,
  required Charlatan charlatan,
  required FirebaseAuth firebaseAuth,
}) async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  await app.runMockApp(firebaseAuthOverride: firebaseAuth, charlatan: charlatan);
  await loginFlow(tester: tester, charlatan: charlatan);

  final preventionMainPage = PreventionPage(tester);
  final openSettingsPage = OpenSettingsPage(tester);
  final updateProfilePage = UpdateProfilePage(tester);
  final deleteAccountPage = DeleteAccountPage(tester);

  await preventionMainPage.clickProfileAvatar();
  expect(find.byType(OpenSettingsScreen), findsOneWidget);

  await openSettingsPage.clickEditProfileButton();
  expect(find.byType(UpdateProfileScreen), findsOneWidget);

  await updateProfilePage.clickDeleteAccountButton();
  expect(find.byType(DeleteAccountScreen), findsOneWidget);

  expect(deleteAccountPage.deleteAccountBtn, findsNothing);
  expect(deleteAccountPage.isCheckBoxChecked(deleteAccountPage.checkBoxDeleteCheckups), false);
  expect(deleteAccountPage.isCheckBoxChecked(deleteAccountPage.checkBoxDeleteBadges), false);
  expect(deleteAccountPage.isCheckBoxChecked(deleteAccountPage.checkBoxStopNotifications), false);

  await deleteAccountPage.clickDeleteCheckupsCheckBox();
  expect(deleteAccountPage.deleteAccountBtn, findsNothing);
  expect(deleteAccountPage.isCheckBoxChecked(deleteAccountPage.checkBoxDeleteCheckups), true);
  expect(deleteAccountPage.isCheckBoxChecked(deleteAccountPage.checkBoxDeleteBadges), false);
  expect(deleteAccountPage.isCheckBoxChecked(deleteAccountPage.checkBoxStopNotifications), false);
  await tester.pump(const Duration(seconds: 1));

  await deleteAccountPage.clickDeleteBadgesCheckBox();
  expect(deleteAccountPage.deleteAccountBtn, findsNothing);
  expect(deleteAccountPage.isCheckBoxChecked(deleteAccountPage.checkBoxDeleteCheckups), true);
  expect(deleteAccountPage.isCheckBoxChecked(deleteAccountPage.checkBoxDeleteBadges), true);
  expect(deleteAccountPage.isCheckBoxChecked(deleteAccountPage.checkBoxStopNotifications), false);

  await deleteAccountPage.clickStopNotificationsCheckBox();
  expect(deleteAccountPage.isCheckBoxChecked(deleteAccountPage.checkBoxDeleteCheckups), true);
  expect(deleteAccountPage.isCheckBoxChecked(deleteAccountPage.checkBoxDeleteBadges), true);
  expect(deleteAccountPage.isCheckBoxChecked(deleteAccountPage.checkBoxStopNotifications), true);

  // all three checkboxes are checked, delete button appears
  await tester.pump(const Duration(seconds: 2));
  expect(deleteAccountPage.deleteAccountBtn, findsOneWidget);
  await deleteAccountPage.clickDeleteAccountButton();
  expect(find.byType(CupertinoAlertDialog), findsOneWidget);

  // fake /delete API response
  charlatan.whenDelete('/account', (_) => CharlatanHttpResponse(statusCode: 200));
  await deleteAccountPage.confirmDeleteAccountDialog();
  expect(find.byType(AfterDeletionScreen), findsOneWidget);
  expect(find.textContaining('Co můžeme udělat pro to, aby ses'), findsOneWidget);
  // TODO: verify launch with email method was called (via method channel handler)?
  // await afterDeletionPage.clickSendEmailButton();
}
