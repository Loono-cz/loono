import 'package:charlatan/charlatan.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:loono_api/loono_api.dart';

import '../../../../setup.dart' as app;
import '../../../../test_helpers/dart_objects_gens.dart';
import '../../../app/flows/login_flow.dart';
import '../../../app/test_data/default_test_data.dart';
import '../../../app/test_data/fake_healthcare_provider_response.dart';
import '../../../prevention/pages/prevention_main_page.dart';
import '../../pages/open_settings_page.dart';
import '../../pages/points/leaderboard_page.dart';
import '../../pages/points/points_help_page.dart';

part '../../test_data/loon_464_test_data.dart';

/// [Test case link](https://cesko-digital.atlassian.net/browse/LOON-464)
Future<void> run({
  required WidgetTester tester,
  required Charlatan charlatan,
  required FirebaseAuth firebaseAuth,
}) async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  await app.runMockApp(firebaseAuthOverride: firebaseAuth, charlatan: charlatan);
  charlatan.whenGet('/providers/all', (_) => HEALTHCARE_PROVIDER_ENCODED);
  await loginFlow(tester: tester, charlatan: charlatan);

  final preventionPage = PreventionPage(tester);
  final openSettingsPage = OpenSettingsPage(tester);
  final pointsHelpPage = PointsHelpPage(tester);
  final leaderboardPage = LeaderboardPage(tester);

  await preventionPage.clickProfileAvatar();
  await openSettingsPage.verifyScreenIsShown();

  await openSettingsPage.clickPointsHelpButton();
  await pointsHelpPage.verifyScreenIsShown();

  await pointsHelpPage.clickBackButton();
  await openSettingsPage.verifyScreenIsShown();

  charlatan.whenGet(
    '/leaderboard',
    (_) => standardSerializers.serializeWith(Leaderboard.serializer, _testDataLeaderboard),
  );
  await openSettingsPage.clickLeaderboardButton();
  await leaderboardPage.verifyScreenIsShown();
  leaderboardPage.checkMeMarkerIsDrawn();

  await leaderboardPage.clickCloseButton();
  await preventionPage.verifyScreenIsShown();
}
