import 'package:charlatan/charlatan.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../../../../setup.dart' as app;
import '../../../app/flows/login_flow.dart';
import '../../../app/test_data/default_test_data.dart';
import '../../../app/test_data/fake_healthcare_provider_response.dart';
import '../../../prevention/pages/prevention_main_page.dart';
import '../../pages/open_settings_page.dart';
import '../../pages/update_profile/edit_email_page.dart';
import '../../pages/update_profile/edit_nickname_page.dart';
import '../../pages/update_profile/update_profile_page.dart';

part '../../test_data/loon_555_test_data.dart';

/// [Test case link](https://cesko-digital.atlassian.net/browse/LOON-555)
Future<void> run({
  required WidgetTester tester,
  required Charlatan charlatan,
}) async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  await app.runMockApp(charlatan: charlatan);
  charlatan.whenGet('/providers/all', (_) => HEALTHCARE_PROVIDER_ENCODED);

  await loginFlow(tester: tester, charlatan: charlatan);

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));

  final preventionPage = PreventionPage(tester);
  final openSettingsPage = OpenSettingsPage(tester);
  final updateProfilePage = UpdateProfilePage(tester);
  final editNicknamePage = EditNicknamePage(tester);
  final editEmailPage = EditEmailPage(tester);

  await preventionPage.clickProfileAvatar();
  await openSettingsPage.verifyScreenIsShown();

  await openSettingsPage.clickEditProfileButton();
  await updateProfilePage.verifyScreenIsShown();
  updateProfilePage
    ..verifyNickname(defaultMaleAccount.nickname)
    ..verifyEmail(defaultMaleAccount.preferredEmail);

  await updateProfilePage.clickNicknameField();
  await editNicknamePage.verifyScreenIsShown();

  await editNicknamePage.insertNickname(_testDataNicknameLong);
  // long text gets stripped
  editNicknamePage.checkInputTextIsValid();

  await editNicknamePage.clickBackButton();
  await updateProfilePage.verifyScreenIsShown();
  updateProfilePage.verifyNickname(defaultMaleAccount.nickname);

  await updateProfilePage.clickEmailField();
  await editEmailPage.verifyScreenIsShown();

  await editEmailPage.insertEmail(_testDataEmailIncorrect1);
  await editEmailPage.clickSaveButton();
  await editEmailPage.verifyScreenIsShown();
  expect(find.text('Nesprávný formát e-mailu'), findsOneWidget);

  await editEmailPage.insertEmail(_testDataEmailIncorrect2);
  await editEmailPage.clickSaveButton();
  await editEmailPage.verifyScreenIsShown();
  expect(find.text('Nesprávný formát e-mailu'), findsOneWidget);

  await editEmailPage.clickBackButton();
  await updateProfilePage.verifyScreenIsShown();
  updateProfilePage.verifyEmail(defaultMaleAccount.preferredEmail);

  await updateProfilePage.clickSexField();
  expect(find.text('Pohlaví teď není možné změnit'), findsOneWidget);

  await updateProfilePage.closeErrorSheet();
  await updateProfilePage.verifyScreenIsShown();

  await updateProfilePage.clickBirthdateField();
  expect(find.text('Věk teď není možné změnit'), findsOneWidget);

  await updateProfilePage.closeErrorSheet();
  await updateProfilePage.verifyScreenIsShown();
}
