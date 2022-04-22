import 'package:charlatan/charlatan.dart';
import 'package:charlatan/src/charlatan_http_response_definition.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loono_api/loono_api.dart';

import '../../prevention/pages/prevention_main_page.dart';
import '../pages/login_page.dart';
import '../pages/welcome_page.dart';
import '../test_data/default_test_data.dart';
import '../test_data/fake_healthcare_provider_response.dart';

///
/// Flows that can be reused in other test cases.
///

// positive case
Future<void> loginFlow({
  required WidgetTester tester,
  required Charlatan charlatan,
  Account? accountData,
  PreventionStatus? examinationsData,
  CharlatanResponseBuilder? accountResponse,
}) async {
  final welcomePage = WelcomePage(tester);
  final loginPage = LoginPage(tester);
  final preventionPage = PreventionPage(tester);

  charlatan
    ..whenGet('/providers/all', (_) => HEALTHCARE_PROVIDER_ENCODED)
    ..whenGet(
      '/account',
      accountResponse ??
          (_) => standardSerializers.serializeWith(
                Account.serializer,
                accountData ?? defaultMaleAccount,
              ),
    )
    ..whenGet(
      '/examinations',
      (_) => standardSerializers.serializeWith(
        PreventionStatus.serializer,
        examinationsData ?? defaultMaleExaminations,
      ),
    );

  await tester.pumpAndSettle();
  await welcomePage.verifyScreenIsShown();

  await welcomePage.clickLoginButton();
  await loginPage.verifyScreenIsShown();

  await loginPage.loginWithGoogle();
  await preventionPage.verifyScreenIsShown();
}
