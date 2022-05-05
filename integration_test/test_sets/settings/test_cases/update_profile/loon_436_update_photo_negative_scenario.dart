import 'package:charlatan/charlatan.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../../../../setup.dart' as app;
import '../../../app/flows/login_flow.dart';
import '../../../app/test_data/fake_healthcare_provider_response.dart';

/// [Test case link](https://cesko-digital.atlassian.net/browse/LOON-436)
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
  // TODO
}
