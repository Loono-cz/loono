import 'package:charlatan/charlatan.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../../../setup.dart' as app;
import '../../app/flows/login_flow.dart';
import '../../app/pages/post_auth_main_screen_page.dart';
import '../pages/find_doctor_page.dart';
import '../test_data/base_doctor_test_data.dart';

/// Test case link description:
/// Bottom sheet with doctors should be not visible when there are no doctors on the
/// currently visible region - an information message should be shown instead.
Future<void> run({
  required WidgetTester tester,
  required Charlatan charlatan,
}) async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  await app.runMockApp(charlatan: charlatan);
  await loginFlow(
    tester: tester,
    charlatan: charlatan,
    providersData: [
      dentistInPrague,
      generalPractitionerInSumperk,
      dermatologistInSumperk2ndFloor,
    ],
  );

  final mainPage = PostAuthMainScreenPage(tester);
  final findDoctorPage = FindDoctorPage(tester);

  await mainPage.clickFindDoctorTab();
  await findDoctorPage.verifyScreenIsShown();
  await findDoctorPage.verifyControlComponentsAreShown();

  await findDoctorPage.verifyDoctorSheetVisibilityState(isShown: true);
  findDoctorPage.verifyDoctorsCountInSheet(expectedCount: 3);

  // Move to location where are no doctors.
  await findDoctorPage.animateToLocation(latLng: olomoucLatLng, locationName: 'Olomouc');
  await findDoctorPage.verifyDoctorSheetVisibilityState(isShown: false);
  await findDoctorPage.verifyNoDoctorsAroundFlushbarVisibilityState(isShown: true);
}
