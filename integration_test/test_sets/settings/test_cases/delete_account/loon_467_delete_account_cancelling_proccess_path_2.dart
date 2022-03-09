import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:loono/ui/screens/settings/delete_account.dart';
import 'package:loono/ui/screens/settings/open_settings.dart';
import 'package:loono/ui/screens/settings/update_profile.dart';

import '../../../../setup.dart' as app;
import '../../../app/flows/login_flow.dart';
import '../../../app_test.dart';
import '../../../prevention/pages/prevention_main_page.dart';
import '../../pages/delete_account_page.dart';
import '../../pages/open_settings_page.dart';
import '../../pages/update_profile_page.dart';

/// [Test case link](https://cesko-digital.atlassian.net/browse/LOON-467)
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('TC(LOON_467): Delete Account - canceling process (path 2)',
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

    await deleteAccountPage.clickDeleteCheckupsCheckBox();
    expect(deleteAccountPage.deleteAccountBtn, findsNothing);
    await tester.pump(const Duration(seconds: 1));

    await deleteAccountPage.clickDeleteBadgesCheckBox();
    expect(deleteAccountPage.deleteAccountBtn, findsNothing);
    await deleteAccountPage.clickStopNotificationsCheckBox();

    // all three checkboxes are checked, delete button appears
    await tester.pump(const Duration(seconds: 2));
    expect(deleteAccountPage.deleteAccountBtn, findsOneWidget);
    await deleteAccountPage.clickDeleteAccountButton();
    expect(find.byType(CupertinoAlertDialog), findsOneWidget);

    await deleteAccountPage.cancelDeleteAccountDialog();
    expect(find.byType(CupertinoAlertDialog), findsNothing);
    expect(find.byType(DeleteAccountScreen), findsOneWidget);
  });
}
