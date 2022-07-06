import 'package:charlatan/charlatan.dart';
import 'package:charlatan/src/charlatan_http_response_definition.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loono_api/loono_api.dart';

import '../../../test_helpers/dart_objects_gens.dart';
import '../../prevention/pages/prevention_main_page.dart';
import '../pages/login_page.dart';
import '../pages/welcome_page.dart';
import '../test_data/default_test_data.dart';

///
/// Flows that can be reused in other test cases.
///

// positive case
Future<void> loginFlow({
  required WidgetTester tester,
  required Charlatan charlatan,
  Account? accountData,
  PreventionStatus? examinationsData,
  List<SimpleHealthcareProvider>? providersData,
  CharlatanResponseBuilder? accountResponse,
  CharlatanResponseBuilder? examinationsResponse,
}) async {
  final welcomePage = WelcomePage(tester);
  final loginPage = LoginPage(tester);
  final preventionPage = PreventionPage(tester);

  charlatan
    ..whenGet(
      '/providers/all',
      (_) => providersData != null
          ? getEncodedProviders(providers: providersData)
          : ENCODED_SINGLE_HEALTHCARE_PROVIDER,
    )
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
      examinationsResponse ??
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
  if (accountResponse == null && examinationsResponse == null) {
    await preventionPage.verifyScreenIsShown();
  }
}
