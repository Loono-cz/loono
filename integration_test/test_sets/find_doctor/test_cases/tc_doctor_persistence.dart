import 'package:charlatan/charlatan.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:loono/helpers/simple_health_care_provider_helper.dart';

import '../../../setup.dart' as app;
import '../../../test_helpers/map_test_utils.dart';
import '../../app/flows/login_flow.dart';
import '../../app/pages/post_auth_main_screen_page.dart';
import '../../prevention/pages/prevention_main_page.dart';
import '../pages/find_doctor_page.dart';
import '../test_data/base_doctor_test_data.dart';

/// Test case link description:
/// When switching between Prevention and Find Doctor bottom navigation tabs, it should preserve
/// the states on both screens.
Future<void> run({
  required WidgetTester tester,
  required Charlatan charlatan,
}) async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  await app.runMockApp(charlatan: charlatan);
  await loginFlow(
    tester: tester,
    charlatan: charlatan,
    providersData: [dentistInPrague],
  );

  final mainPage = PostAuthMainScreenPage(tester);
  final preventionPage = PreventionPage(tester);
  final findDoctorPage = FindDoctorPage(tester);

  await mainPage.clickFindDoctorTab();
  await findDoctorPage.verifyScreenIsShown();
  await findDoctorPage.verifyControlComponentsAreShown();

  await findDoctorPage.animateToLocation(
    latLng: dentistInPrague.latLng,
    locationName: dentistInPrague.city,
  );

  await findDoctorPage.verifyDoctorSheetVisibilityState(isShown: true);
  findDoctorPage.verifyDoctorsCountInSheet(expectedCount: 1);

  await findDoctorPage.dragSheetUp();
  await findDoctorPage.verifyDoctorDetailSheetVisibilityState(isShown: false);

  await findDoctorPage.clickDoctorCardById(dentistInPrague.uniqueId);
  await findDoctorPage.verifyDoctorDetailSheetVisibilityState(isShown: true);

  await mainPage.clickPreventionTab();
  await preventionPage.verifyScreenIsShown();

  await mainPage.clickFindDoctorTab();
  await findDoctorPage.verifyScreenIsShown();
  await findDoctorPage.verifyDoctorDetailSheetVisibilityState(isShown: true);
}
