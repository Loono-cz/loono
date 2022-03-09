import 'package:charlatan/charlatan.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'onboarding/test_cases/questionnaire/loon_543_male_onboarding_flow.dart' as loon543;
import 'onboarding/test_cases/questionnaire/loon_x_onboarding_age_validation.dart' as loonx;
import 'settings/test_cases/delete_account/loon_465_delete_account_and_contact_straight_path.dart'
    as loon465;
import 'settings/test_cases/delete_account/loon_466_delete_account_cancelling_proccess.dart'
    as loon466;
import 'settings/test_cases/delete_account/loon_467_delete_account_cancelling_proccess_path_2.dart'
    as loon467;
import 'settings/test_cases/logout/loon_437_logout_straight_path.dart' as loon437;
import 'settings/test_cases/logout/loon_438_logout_cancelling_process.dart' as loon438;
import 'settings/test_cases/logout/loon_439_logout_relogging.dart' as loon439;
import 'settings/test_cases/points/loon_464_view_points_and_leaderboard.dart' as loon464;

late Charlatan charlatan;
FirebaseAuth? firebaseAuth;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Onboarding', () {
    group('Questionnaire', () {
      loon543.main();
      loonx.main();
    });
  });

  group('Settings', () {
    group('Delete Account', () {
      loon465.main();
      loon466.main();
      loon467.main();
    });

    group('Logout', () {
      loon437.main();
      loon438.main();
      loon439.main();
    });

    // ignore: unnecessary_lambdas
    group('Points', () {
      loon464.main();
    });
  });
}
