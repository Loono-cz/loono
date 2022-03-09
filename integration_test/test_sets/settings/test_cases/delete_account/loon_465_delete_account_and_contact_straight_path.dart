import 'package:charlatan/charlatan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:loono/ui/screens/settings/after_deletion.dart';
import 'package:loono/ui/screens/settings/delete_account.dart';
import 'package:loono/ui/screens/settings/open_settings.dart';
import 'package:loono/ui/screens/settings/update_profile.dart';

import '../../../../mocks/firebase_auth_mock.dart';
import '../../../../mocks/google_sign_in_mock.dart';
import '../../../../setup.dart' as app;
import '../../../../test_helpers/post_app_clear.dart';
import '../../../app/flows/login_flow.dart';
import '../../../app_test.dart';
import '../../../prevention/pages/prevention_main_page.dart';
import '../../pages/delete_account_page.dart';
import '../../pages/open_settings_page.dart';
import '../../pages/update_profile_page.dart';

/// [Test case link](https://cesko-digital.atlassian.net/browse/LOON-465)
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

  testWidgets('TC(LOON_465): Delete Account & Contact Loono support (straight path)',
      (WidgetTester tester) async {
    await app.runMockApp(firebaseAuthOverride: firebaseAuth, charlatan: charlatan);
    await loginFlow(tester: tester, charlatan: charlatan);

    final preventionMainPage = PreventionMainPage(tester);
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
    expect(find.textContaining('Tvůj účet jsme smazali'), findsOneWidget);

    // TODO: verify launch with email method was called (via method channel handler)?
    // await afterDeletionPage.clickSendEmailButton();
  });
}
