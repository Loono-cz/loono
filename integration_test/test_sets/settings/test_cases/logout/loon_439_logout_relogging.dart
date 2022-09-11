import 'package:charlatan/charlatan.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../../../../setup.dart' as app;
import '../../../app/flows/login_flow.dart';
import '../../../app/pages/login_page.dart';
import '../../../app/pages/logout_page.dart';
import '../../../app/pages/post_auth_main_screen_page.dart';
import '../../../prevention/pages/prevention_main_page.dart';
import '../../pages/open_settings_page.dart';

/// [Test case link](https://cesko-digital.atlassian.net/browse/LOON-439)
Future<void> run({
  required WidgetTester tester,
  required Charlatan charlatan,
}) async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  await app.runMockApp(charlatan: charlatan);
  await loginFlow(tester: tester, charlatan: charlatan);

  final preventionPage = PreventionPage(tester);
  final openSettingsPage = OpenSettingsPage(tester);
  final logoutPage = LogoutPage(tester);
  final loginPage = LoginPage(tester);
  final mainPage = PostAuthMainScreenPage(tester);

  await preventionPage.clickProfileAvatar();
  await openSettingsPage.verifyScreenIsShown();

  await openSettingsPage.clickLogoutButton();

  await openSettingsPage.verifyConfirmationDialogVisibilityState(isShown: true);

  await openSettingsPage.confirmLogoutDialog();
  await logoutPage.verifyScreenIsShown();

  await logoutPage.clickLoginButton();
  await loginPage.verifyScreenIsShown();

  await loginPage.loginWithGoogle();
  await mainPage.verifyScreenIsShown();
}
