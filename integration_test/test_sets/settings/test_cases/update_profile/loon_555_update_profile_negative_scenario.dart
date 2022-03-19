import 'package:charlatan/charlatan.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:loono/ui/screens/settings/edit_email.dart';
import 'package:loono/ui/screens/settings/edit_nickname.dart';
import 'package:loono/ui/screens/settings/open_settings.dart';
import 'package:loono/ui/screens/settings/update_profile.dart';

import '../../../../setup.dart' as app;
import '../../../app/flows/login_flow.dart';
import '../../../app/test_data/default_test_data.dart';
import '../../../app/test_data/fake_healthcare_provider_response.dart';
import '../../../onboarding/pages/questionnaire_done_page.dart';
import '../../pages/open_settings_page.dart';
import '../../pages/update_profile/edit_email_page.dart';
import '../../pages/update_profile/edit_nickname_page.dart';
import '../../pages/update_profile/update_profile_page.dart';

part '../../test_data/loon_555_test_data.dart';

/// [Test case link](https://cesko-digital.atlassian.net/browse/LOON-555)
Future<void> run({
  required WidgetTester tester,
  required Charlatan charlatan,
  required FirebaseAuth firebaseAuth,
}) async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  await app.runMockApp(firebaseAuthOverride: firebaseAuth, charlatan: charlatan);
  charlatan.whenGet('/providers/all', (_) => HEALTHCARE_PROVIDER_ENCODED);

  await loginFlow(tester: tester, charlatan: charlatan);

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 3));

  final preventionMainPage = PreventionMainPage(tester);
  final openSettingsPage = OpenSettingsPage(tester);
  final updateProfilePage = UpdateProfilePage(tester);
  final editNicknamePage = EditNicknamePage(tester);
  final editEmailPage = EditEmailPage(tester);

  await preventionMainPage.clickProfileAvatar();
  expect(find.byType(OpenSettingsScreen), findsOneWidget);

  await openSettingsPage.clickEditProfileButton();
  expect(find.byType(UpdateProfileScreen), findsOneWidget);
  updateProfilePage
    ..verifyNickname(defaultAccount.nickname)
    ..verifyEmail(defaultAccount.prefferedEmail);

  await updateProfilePage.clickNicknameField();
  expect(find.byType(EditNicknameScreen), findsOneWidget);
  await editNicknamePage.insertNickname(_testDataNicknameLong);
  // long text gets stripped
  editNicknamePage.checkInputTextIsValid();

  await editNicknamePage.clickBackButton();
  expect(find.byType(UpdateProfileScreen), findsOneWidget);
  updateProfilePage.verifyNickname(defaultAccount.nickname);

  await updateProfilePage.clickEmailField();
  expect(find.byType(EditEmailScreen), findsOneWidget);

  await editEmailPage.insertEmail(_testDataEmailIncorrect1);
  await editEmailPage.clickSaveButton();
  expect(find.byType(EditEmailScreen), findsOneWidget);
  expect(find.text('Nesprávný formát e-mailu'), findsOneWidget);

  await editEmailPage.insertEmail(_testDataEmailIncorrect2);
  await editEmailPage.clickSaveButton();
  expect(find.byType(EditEmailScreen), findsOneWidget);
  expect(find.text('Nesprávný formát e-mailu'), findsOneWidget);

  await editEmailPage.clickBackButton();
  expect(find.byType(UpdateProfileScreen), findsOneWidget);
  updateProfilePage.verifyEmail(defaultAccount.prefferedEmail);

  await updateProfilePage.clickSexField();
  expect(find.text('Pohlaví teď není možné změnit'), findsOneWidget);
  await updateProfilePage.closeErrorSheet();
  expect(find.byType(UpdateProfileScreen), findsOneWidget);

  await updateProfilePage.clickBirthdateField();
  expect(find.text('Věk teď není možné změnit'), findsOneWidget);
  await updateProfilePage.closeErrorSheet();
  expect(find.byType(UpdateProfileScreen), findsOneWidget);
}
