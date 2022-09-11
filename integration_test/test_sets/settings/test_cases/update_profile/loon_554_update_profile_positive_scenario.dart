import 'package:charlatan/charlatan.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:loono_api/loono_api.dart';

import '../../../../setup.dart' as app;
import '../../../app/flows/login_flow.dart';
import '../../../app/test_data/default_test_data.dart';
import '../../../prevention/pages/prevention_main_page.dart';
import '../../pages/open_settings_page.dart';
import '../../pages/update_profile/edit_email_page.dart';
import '../../pages/update_profile/edit_nickname_page.dart';
import '../../pages/update_profile/update_profile_page.dart';

part '../../test_data/loon_554_test_data.dart';

/// [Test case link](https://cesko-digital.atlassian.net/browse/LOON-554)
Future<void> run({
  required WidgetTester tester,
  required Charlatan charlatan,
}) async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  await app.runMockApp(charlatan: charlatan);
  charlatan.whenGet('/providers/all', (_) => ENCODED_SINGLE_HEALTHCARE_PROVIDER);

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
  await updateProfilePage.clickUserDataSection();
  updateProfilePage
    ..verifyNickname(defaultMaleAccount.nickname)
    ..verifyEmail(defaultMaleAccount.preferredEmail);

  charlatan.whenPost(
    '/account',
    (request) {
      final data = request.body as Map<String, Object?>? ?? {};
      final nickname = data['nickname'] as String?;
      if (nickname == null) {
        return CharlatanHttpResponse(statusCode: 422, body: 'Error: Body is empty.');
      }
      return CharlatanHttpResponse(
        statusCode: 200,
        body: standardSerializers.serializeWith(
          Account.serializer,
          defaultMaleAccount.rebuild((b) => b.nickname = nickname),
        ),
      );
    },
  );

  await updateProfilePage.clickNicknameField();
  await editNicknamePage.verifyScreenIsShown();

  await editNicknamePage.insertNickname(_testDataNickname);
  await editNicknamePage.clickSaveButton();

  await updateProfilePage.verifyScreenIsShown();
  updateProfilePage
    ..verifyNickname(_testDataNickname)
    ..verifyEmail(defaultMaleAccount.preferredEmail);

  charlatan.whenPost(
    '/account',
    (request) {
      final data = request.body as Map<String, Object?>? ?? {};
      final preferredEmail = data['preferredEmail'] as String?;
      if (preferredEmail == null) {
        return CharlatanHttpResponse(statusCode: 422, body: 'Error: Body is empty.');
      }
      return CharlatanHttpResponse(
        statusCode: 200,
        body: standardSerializers.serializeWith(
          Account.serializer,
          defaultMaleAccount.rebuild((b) => b.preferredEmail = preferredEmail),
        ),
      );
    },
  );

  await updateProfilePage.clickEmailField();
  await editEmailPage.verifyScreenIsShown();

  await editEmailPage.insertEmail(_testDataEmail);
  await editEmailPage.clickSaveButton();

  await updateProfilePage.verifyScreenIsShown();
  updateProfilePage
    ..verifyNickname(_testDataNickname)
    ..verifyEmail(_testDataEmail);
}
