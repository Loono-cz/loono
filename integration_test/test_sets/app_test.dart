import 'dart:io';

import 'package:charlatan/charlatan.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../mocks/firebase_auth_mock.dart';
import '../mocks/google_sign_in_mock.dart';
import '../test_helpers/post_app_clear.dart';
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

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Onboarding', () {
    group('Questionnaire', () {
      late Charlatan charlatan;

      setUp(() {
        charlatan = Charlatan();
      });

      tearDown(() async {
        await postAppClear();
      });

      testWidgets(
        'TC(LOON_543): (Male) Onboarding Questionnaire - no account',
        (tester) async => loon543.run(tester: tester, charlatan: charlatan),
        // TODO: on iOS there is slightly different routing in the onboarding form
        skip: Platform.isIOS,
      );

      testWidgets(
        'TC(LOON_X): Onboarding age validation',
        (tester) async => loonx.run(tester: tester, charlatan: charlatan),
      );
    });
  });

  group('Settings', () {
    group('Delete Account', () {
      late Charlatan charlatan;
      late FirebaseAuth firebaseAuth;

      setUp(() async {
        mockGoogleSignIn();
        firebaseAuth = await mockFirebaseAuth();
        charlatan = Charlatan();
      });

      tearDown(() async {
        await postAppClear();
      });

      testWidgets(
        'TC(LOON_465): Delete Account & Contact Loono support (straight path)',
        (tester) async =>
            loon465.run(tester: tester, charlatan: charlatan, firebaseAuth: firebaseAuth),
      );

      testWidgets(
        'TC(LOON_466): Delete Account - canceling process (path 1)',
        (tester) async =>
            loon466.run(tester: tester, charlatan: charlatan, firebaseAuth: firebaseAuth),
      );

      testWidgets(
        'TC(LOON_467): Delete Account - canceling process (path 2)',
        (tester) async =>
            loon467.run(tester: tester, charlatan: charlatan, firebaseAuth: firebaseAuth),
      );
    });

    group('Logout', () {
      late Charlatan charlatan;
      late FirebaseAuth firebaseAuth;

      setUp(() async {
        mockGoogleSignIn();
        firebaseAuth = await mockFirebaseAuth();
        charlatan = Charlatan();
      });

      tearDown(() async {
        await postAppClear();
      });

      testWidgets(
        'TC(LOON_437): Logout (straight path)',
        (tester) async =>
            loon437.run(tester: tester, charlatan: charlatan, firebaseAuth: firebaseAuth),
      );

      testWidgets(
        'TC(LOON_438): Logout (cancelling process)',
        (tester) async =>
            loon438.run(tester: tester, charlatan: charlatan, firebaseAuth: firebaseAuth),
      );

      testWidgets(
        'TC(LOON_439): Logout (re-logging after successful logout)',
        (tester) async =>
            loon439.run(tester: tester, charlatan: charlatan, firebaseAuth: firebaseAuth),
      );
    });

    group('Points', () {
      late Charlatan charlatan;
      late FirebaseAuth firebaseAuth;

      setUp(() async {
        mockGoogleSignIn();
        firebaseAuth = await mockFirebaseAuth();
        charlatan = Charlatan();
      });

      tearDown(() async {
        await postAppClear();
      });

      testWidgets(
        'TC(LOON_464): View Points & Leaderboard',
        (tester) async =>
            loon464.run(tester: tester, charlatan: charlatan, firebaseAuth: firebaseAuth),
        skip: true,
      );
    });
  });
}
