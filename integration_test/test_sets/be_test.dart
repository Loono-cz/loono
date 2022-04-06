import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../test_helpers/post_app_clear.dart';
import 'app/test_cases/be_flow.dart' as be_test1;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Backend', () {
    tearDown(() async {
      await postAppClear();
    });

    testWidgets(
      'TC(BE-1): Basic signup and post-signup flow',
      (tester) async => be_test1.run(tester: tester),
    );
  });
}
