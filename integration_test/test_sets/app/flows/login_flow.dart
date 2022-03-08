import 'package:charlatan/charlatan.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/screens/main/pre_auth/login.dart';
import 'package:loono/ui/screens/welcome.dart';
import 'package:loono_api/loono_api.dart';

import '../../../setup.dart';
import '../pages/login_page.dart';
import '../pages/welcome_page.dart';
import '../test_data/default_test_data.dart';

///
/// Flows that can be reused in other test cases.
///

// positive case
Future<void> loginFlow({required WidgetTester tester}) async {
  final welcomePage = WelcomePage(tester);
  final loginPage = LoginPage(tester);

  charlatan
    ..whenGet('/providers/all', (_) => CharlatanHttpResponse(statusCode: 404))
    ..whenGet(
      '/account',
      (_) => standardSerializers.serializeWith(Account.serializer, defaultAccount),
    )
    ..whenGet(
      '/examinations',
      (_) => standardSerializers.serializeWith(PreventionStatus.serializer, defaultExaminations),
    );

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 2));
  expect(find.byType(WelcomeScreen), findsOneWidget);

  await welcomePage.clickLoginButton();
  expect(find.byType(LoginScreen), findsOneWidget);

  await loginPage.loginWithGoogle();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 2));
}
