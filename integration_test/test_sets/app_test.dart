import 'dart:io';

import 'package:charlatan/charlatan.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../mocks/firebase_auth_mock.dart';
import '../mocks/google_sign_in_mock.dart';
import '../test_helpers/post_app_clear.dart';
import 'app/test_cases/loon_580_force_update.dart' as loon580;
import 'onboarding/test_cases/other/loon_542_installing_and_opening_app.dart' as loon542;
import 'onboarding/test_cases/other/loon_671_login_server_down_block_user.dart' as loon671;
import 'onboarding/test_cases/questionnaire/loon_543_male_onboarding_flow.dart' as loon543;
import 'onboarding/test_cases/questionnaire/loon_544_female_onboarding_flow.dart' as loon544;
import 'onboarding/test_cases/questionnaire/loon_558_onboarding_age_validation.dart' as loon558;
import 'prevention/test_cases/self_examination/detail/loon_566_self_exam_detail_male.dart'
    as loon566;
import 'prevention/test_cases/self_examination/detail/loon_567_self_exam_detail_female.dart'
    as loon567;
import 'prevention/test_cases/self_examination/detail/loon_568_self_exam_find_doctor_from_faq_path.dart'
    as loon568;
import 'prevention/test_cases/self_examination/educational_video/loon_561_educational_video_active_path.dart'
    as loon561;
import 'prevention/test_cases/self_examination/educational_video/loon_562_educational_video_inactive_path.dart'
    as loon562;
import 'prevention/test_cases/self_examination/educational_video/loon_563_educational_video_closing_process_path.dart'
    as loon563;
import 'prevention/test_cases/self_examination/perform_self_examination/loon_564_perform_self_exam_has_finding_closing_process_path.dart'
    as loon564;
import 'prevention/test_cases/self_examination/perform_self_examination/loon_565_perform_self_exam_has_finding_find_doctor_path.dart'
    as loon565;
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

  group('App', () {
    group('Force update feature', () {
      late Charlatan charlatan;

      setUp(() async {
        mockGoogleSignIn();
        await mockFirebaseAuth();
        charlatan = Charlatan();
      });

      tearDown(() async {
        await postAppClear();
      });

      testWidgets(
        'TC(LOON-580): Force update - routing is blocked',
        (tester) async => loon580.run(tester: tester, charlatan: charlatan),
      );
    });
  });

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
        'TC(LOON-543): (Male) Onboarding Questionnaire - no account',
        (tester) async => loon543.run(tester: tester, charlatan: charlatan),
        // TODO: on iOS there is slightly different routing in the onboarding form
        skip: Platform.isIOS,
      );

      testWidgets(
        'TC(LOON-544): (Female) Onboarding Questionnaire - no account',
        (tester) async => loon544.run(tester: tester, charlatan: charlatan),
        // TODO: on iOS there is slightly different routing in the onboarding form
        skip: Platform.isIOS,
      );

      testWidgets(
        'TC(LOON-558): Onboarding Questionnaire - Age validation rule (negative)',
        (tester) async => loon558.run(tester: tester, charlatan: charlatan),
      );
    });

    group('Other', () {
      late Charlatan charlatan;

      setUp(() async {
        charlatan = Charlatan();
        mockGoogleSignIn();
        await mockFirebaseAuth();
      });

      tearDown(() async {
        await postAppClear();
      });

      testWidgets(
        'TC(LOON-542): Installing & opening app - Intro & Pre-auth Main Screen routes',
        (tester) async => loon542.run(tester: tester, charlatan: charlatan),
        timeout: const Timeout(Duration(minutes: 2)),
      );

      testWidgets(
        'TC(LOON-671): Blocking the user from logging in when the server is down',
        (tester) async => loon671.run(tester: tester, charlatan: charlatan),
      );
    });
  });

  group('Settings', () {
    group('Delete Account', () {
      late Charlatan charlatan;

      setUp(() async {
        mockGoogleSignIn();
        await mockFirebaseAuth();
        charlatan = Charlatan();
      });

      tearDown(() async {
        await postAppClear();
      });

      testWidgets(
        'TC(LOON-465): Delete Account & Contact Loono support (straight path)',
        (tester) async => loon465.run(tester: tester, charlatan: charlatan),
      );

      testWidgets(
        'TC(LOON-466): Delete Account - canceling process (path 1)',
        (tester) async => loon466.run(tester: tester, charlatan: charlatan),
      );

      testWidgets(
        'TC(LOON-467): Delete Account - canceling process (path 2)',
        (tester) async => loon467.run(tester: tester, charlatan: charlatan),
      );
    });

    group('Logout', () {
      late Charlatan charlatan;

      setUp(() async {
        mockGoogleSignIn();
        await mockFirebaseAuth();
        charlatan = Charlatan();
      });

      tearDown(() async {
        await postAppClear();
      });

      testWidgets(
        'TC(LOON-437): Logout (straight path)',
        (tester) async => loon437.run(tester: tester, charlatan: charlatan),
      );

      testWidgets(
        'TC(LOON-438): Logout (cancelling process)',
        (tester) async => loon438.run(tester: tester, charlatan: charlatan),
      );

      testWidgets(
        'TC(LOON-439): Logout (re-logging after successful logout)',
        (tester) async => loon439.run(tester: tester, charlatan: charlatan),
      );
    });

    group('Update profile', () {
      late Charlatan charlatan;

      setUp(() async {
        mockGoogleSignIn();
        await mockFirebaseAuth();
        charlatan = Charlatan();
      });

      tearDown(() async {
        await postAppClear();
      });

      testWidgets(
        'TC(LOON-554): Updating profile information - Positive scenario',
        (tester) async => loon554.run(tester: tester, charlatan: charlatan),
      );

      testWidgets(
        'TC(LOON-555): Updating profile information - Negative scenario',
        (tester) async => loon555.run(tester: tester, charlatan: charlatan),
      );

      testWidgets(
        'TC(LOON-435): Update profile (photo actions) - Positive scenario',
        (tester) async => loon435.run(tester: tester, charlatan: charlatan),
        skip: true,
      );

      testWidgets(
        'TC(LOON-436): Update profile (photo actions) - Negative scenario',
        (tester) async => loon436.run(tester: tester, charlatan: charlatan),
        skip: true,
      );
    });

    group('Points', () {
      late Charlatan charlatan;

      setUp(() async {
        mockGoogleSignIn();
        await mockFirebaseAuth();
        charlatan = Charlatan();
      });

      tearDown(() async {
        await postAppClear();
      });

      testWidgets(
        'TC(LOON-464): View Points & Leaderboard',
        (tester) async => loon464.run(tester: tester, charlatan: charlatan),
      );
    });
  });

  group('Prevention', () {
    late Charlatan charlatan;

    setUp(() async {
      mockGoogleSignIn();
      await mockFirebaseAuth();
      charlatan = Charlatan();
    });

    tearDown(() async {
      await postAppClear();
    });

    group('Examination', () {
      // TODO:
    });

    group('Self Examination', () {
      group('Perform Self Examination', () {
        testWidgets(
          'TC(LOON-565):  Performing self-examination - Has finding - find doctor path',
          (tester) async => loon565.run(tester: tester, charlatan: charlatan),
        );

        testWidgets(
          'TC(LOON-564): Performing self-examination - Has finding - closing process path',
          (tester) async => loon564.run(tester: tester, charlatan: charlatan),
        );
      });

      group('Detail', () {
        testWidgets(
          'TC(LOON-568): View details of self-examination - Find doctor from FAQ section path',
          (tester) async => loon568.run(tester: tester, charlatan: charlatan),
        );

        testWidgets(
          'TC(LOON-567): View details of self-examination - Female',
          (tester) async => loon567.run(tester: tester, charlatan: charlatan),
        );

        testWidgets(
          'TC(LOON-566): View details of self-examination - Male',
          (tester) async => loon566.run(tester: tester, charlatan: charlatan),
        );
      });

      group('Educational Video', () {
        testWidgets(
          'TC(LOON-561): Educational Video - active self-examination path',
          (tester) async => loon561.run(tester: tester, charlatan: charlatan),
        );

        testWidgets(
          'TC(LOON-562): Educational Video - inactive self-examination path',
          (tester) async => loon562.run(tester: tester, charlatan: charlatan),
        );

        testWidgets(
          'TC(LOON-563): Educational Video - closing process path',
          (tester) async => loon563.run(tester: tester, charlatan: charlatan),
        );
      });
    });
  });
}
