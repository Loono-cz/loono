import 'package:charlatan/charlatan.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../../../../setup.dart' as app;
import '../../../app/flows/login_flow.dart';
import '../../../app/pages/after_deletion_page.dart';
import '../../../prevention/pages/prevention_main_page.dart';
import '../../pages/open_settings_page.dart';
import '../../pages/update_profile/delete_account_page.dart';
import '../../pages/update_profile/update_profile_page.dart';

/// [Test case link](https://cesko-digital.atlassian.net/browse/LOON-465)
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
  final afterDeletionPage = AfterDeletionPage(tester);

  await preventionPage.clickProfileAvatar();
  await openSettingsPage.verifyScreenIsShown();

  await openSettingsPage.clickEditProfileButton();
  await updateProfilePage.verifyScreenIsShown();

  await updateProfilePage.clickDeleteAccountButton();
  await deleteAccountPage.verifyScreenIsShown();
  await deleteAccountPage.verifyDeleteAccountButtonVisibilityState(isShown: false);

  deleteAccountPage.verifyCheckBoxStates(
    isDeleteCheckupsCheckBoxChecked: false,
    isDeleteBadgesCheckBoxChecked: false,
    isStopNotificationsCheckBoxChecked: false,
  );

  await deleteAccountPage.clickDeleteCheckupsCheckBox();
  deleteAccountPage.verifyCheckBoxStates(
    isDeleteCheckupsCheckBoxChecked: true,
    isDeleteBadgesCheckBoxChecked: false,
    isStopNotificationsCheckBoxChecked: false,
  );
  await deleteAccountPage.verifyDeleteAccountButtonVisibilityState(isShown: false);
  await tester.pump(const Duration(seconds: 1));

  await deleteAccountPage.clickDeleteBadgesCheckBox();
  await deleteAccountPage.verifyDeleteAccountButtonVisibilityState(isShown: false);
  deleteAccountPage.verifyCheckBoxStates(
    isDeleteCheckupsCheckBoxChecked: true,
    isDeleteBadgesCheckBoxChecked: true,
    isStopNotificationsCheckBoxChecked: false,
  );

  // all three checkboxes are checked, delete button appears
  await deleteAccountPage.clickStopNotificationsCheckBox();
  deleteAccountPage.verifyCheckBoxStates(
    isDeleteCheckupsCheckBoxChecked: true,
    isDeleteBadgesCheckBoxChecked: true,
    isStopNotificationsCheckBoxChecked: true,
  );
  await tester.pump(const Duration(seconds: 1));
  await deleteAccountPage.verifyDeleteAccountButtonVisibilityState(isShown: true);

  await deleteAccountPage.clickDeleteAccountButton();
  await deleteAccountPage.verifyDeleteAccountDialogVisibilityState(isShown: true);

  // fake /delete API response
  charlatan.whenDelete('/account', (_) => CharlatanHttpResponse(statusCode: 200));
  await deleteAccountPage.confirmDeleteAccountDialog();
  await afterDeletionPage.verifyScreenIsShown();
  expect(find.textContaining('Co můžeme udělat pro to, aby ses'), findsOneWidget);
  // TODO: verify launch with email method was called (via method channel handler)?
  // await afterDeletionPage.clickSendEmailButton();
}
