import 'package:charlatan/charlatan.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../../../../setup.dart' as app;
import '../../../app/flows/login_flow.dart';
import '../../../prevention/pages/prevention_main_page.dart';
import '../../pages/open_settings_page.dart';
import '../../pages/update_profile/delete_account_page.dart';
import '../../pages/update_profile/update_profile_page.dart';

/// [Test case link](https://cesko-digital.atlassian.net/browse/LOON-466)
Future<void> run({
  required WidgetTester tester,
  required Charlatan charlatan,
}) async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  await app.runMockApp(charlatan: charlatan);
  await loginFlow(tester: tester, charlatan: charlatan);

  final preventionPage = PreventionPage(tester);
  final openSettingsPage = OpenSettingsPage(tester);
  final updateProfilePage = UpdateProfilePage(tester);
  final deleteAccountPage = DeleteAccountPage(tester);

  await preventionPage.clickProfileAvatar();
  await openSettingsPage.verifyScreenIsShown();

  await openSettingsPage.clickEditProfileButton();
  await updateProfilePage.verifyScreenIsShown();

  await updateProfilePage.clickDeleteAccountButton();
  await deleteAccountPage.verifyScreenIsShown();

  await deleteAccountPage.clickDeleteCheckupsCheckBox();
  await tester.pump(const Duration(seconds: 1));

  await deleteAccountPage.clickDeleteBadgesCheckBox();
  await deleteAccountPage.verifyDeleteAccountButtonIsNotShown();

  // all three checkboxes are checked, delete button appears
  await deleteAccountPage.clickStopNotificationsCheckBox();
  await tester.pump(const Duration(seconds: 1));
  await deleteAccountPage.verifyDeleteAccountButtonIsShown();

  // close screen
  // TODO: should be modal and should be PreventionScreen / MainScreen
  await deleteAccountPage.clickCloseScreenButton();
}
