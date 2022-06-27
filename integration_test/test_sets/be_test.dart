import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:loono/repositories/user_repository.dart';
import 'package:loono/services/auth/auth_service.dart';
import 'package:loono/utils/registry.dart';

import '../test_helpers/e2e_action_logging.dart';
import '../test_helpers/post_app_clear.dart';
import 'app/test_cases/be_flow.dart' as be_test1;

// Set to 'true' if running locally to not clutter the Firebase and DB while testing out.
const bool _removeAccountAfterTest = false;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Backend', () {
    tearDown(() async {
      if (_removeAccountAfterTest) {
        await registry.get<UserRepository>().deleteAccount();
        try {
          await registry.get<AuthService>().getCurrentUser().then((user) async {
            if (user != null) await user.delete();
          });
        } catch (_) {}
      }
      await postAppClear();
    });

    testWidgets(
      'TC(BE-1): Basic signup and post-signup flow',
      (tester) async {
        logTestStart('be_test1');
        await be_test1.run(tester: tester);
      },
    );
  });
}
