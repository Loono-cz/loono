import 'dart:io';

import 'package:charlatan/charlatan.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../mocks/firebase_auth_mock.dart';
import '../mocks/google_sign_in_mock.dart';
import '../test_helpers/post_app_clear.dart';
import 'onboarding/test_cases/other/loon_542_installing_and_opening_app.dart' as loon542;
import 'onboarding/test_cases/questionnaire/loon_543_male_onboarding_flow.dart' as loon543;
import 'onboarding/test_cases/questionnaire/loon_544_female_onboarding_flow.dart' as loon544;
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
import 'settings/test_cases/update_profile/loon_435_update_photo_positive_scenario.dart' as loon435;
import 'settings/test_cases/update_profile/loon_436_update_photo_negative_scenario.dart' as loon436;
import 'settings/test_cases/update_profile/loon_554_update_profile_positive_scenario.dart'
    as loon554;
import 'settings/test_cases/update_profile/loon_555_update_profile_negative_scenario.dart'
    as loon555;

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
        'TC(LOON_544): (Female) Onboarding Questionnaire - no account',
        (tester) async => loon544.run(tester: tester, charlatan: charlatan),
        // TODO: on iOS there is slightly different routing in the onboarding form
        skip: Platform.isIOS,
      );

      testWidgets(
        'TC(LOON_X): Onboarding age validation',
        (tester) async => loonx.run(tester: tester, charlatan: charlatan),
      );
    });

    group('Other', () {
      late Charlatan charlatan;

      setUp(() {
        charlatan = Charlatan();
      });

      tearDown(() async {
        await postAppClear();
      });

      testWidgets(
        'TC(LOON_542): Installing & opening app - Intro & Pre-auth Main Screen routes',
        (tester) async => loon542.run(tester: tester, charlatan: charlatan),
        timeout: const Timeout(Duration(minutes: 2)),
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

    group('Update profile', () {
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
        'TC(LOON_554): Updating profile information - Positive scenario',
        (tester) async =>
            loon554.run(tester: tester, charlatan: charlatan, firebaseAuth: firebaseAuth),
      );

      testWidgets(
        'TC(LOON_555): Updating profile information - Negative scenario',
        (tester) async =>
            loon555.run(tester: tester, charlatan: charlatan, firebaseAuth: firebaseAuth),
      );

      testWidgets(
        'TC(LOON_435): Update profile (photo actions) - Positive scenario',
        (tester) async =>
            loon435.run(tester: tester, charlatan: charlatan, firebaseAuth: firebaseAuth),
        skip: true,
      );

      testWidgets(
        'TC(LOON_436): Update profile (photo actions) - Negative scenario',
        (tester) async =>
            loon436.run(tester: tester, charlatan: charlatan, firebaseAuth: firebaseAuth),
        skip: true,
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
      );
    });
  });
}
