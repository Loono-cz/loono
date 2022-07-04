import 'package:charlatan/charlatan.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../../../setup.dart' as app;
import '../../app/flows/login_flow.dart';
import '../../app/pages/post_auth_main_screen_page.dart';
import '../pages/doctor_search_detail_page.dart';
import '../pages/find_doctor_page.dart';
import '../test_data/base_doctor_test_data.dart';

/// Test case link description:
/// TODO
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
    ],
  );

  final mainPage = PostAuthMainScreenPage(tester);
  final findDoctorPage = FindDoctorPage(tester);
  final doctorSearchDetailPage = DoctorSearchDetailPage(tester);

  await mainPage.clickFindDoctorTab();
  await findDoctorPage.verifyScreenIsShown();
  await findDoctorPage.verifyControlComponentsAreShown();

  await findDoctorPage.clickSearchField();
  await doctorSearchDetailPage.verifyScreenIsShown();
  doctorSearchDetailPage.verifySearchHistoryVisibilityState(isShown: false);

  await doctorSearchDetailPage.insertSearchText('prah');
  doctorSearchDetailPage.verifySearchResultCount(expectedCount: 1);

  await doctorSearchDetailPage.clickSearchResultItem(position: 1);
  await findDoctorPage.waitForCameraToStop();
  await findDoctorPage.verifyDoctorSheetVisibilityState(isShown: true);
  await findDoctorPage.verifyVisibleAreaProviderState(
    dentistInPrague,
    isVisible: true,
  );
  await findDoctorPage.verifyVisibleAreaProviderState(
    generalPractitionerInSumperk,
    isVisible: false,
  );

  await findDoctorPage.clickSearchField();
  await doctorSearchDetailPage.verifyScreenIsShown();
  doctorSearchDetailPage
    ..verifySearchResultCount(expectedCount: 1)
    ..verifySearchHistoryVisibilityState(isShown: true);

  await doctorSearchDetailPage.insertSearchText('sum');
  doctorSearchDetailPage.verifySearchResultCount(expectedCount: 1);

  await doctorSearchDetailPage.clickSearchResultItem(position: 1);
  await findDoctorPage.waitForCameraToStop();
  await findDoctorPage.verifyDoctorSheetVisibilityState(isShown: true);
  await findDoctorPage.verifyVisibleAreaProviderState(
    dentistInPrague,
    isVisible: false,
  );
  await findDoctorPage.verifyVisibleAreaProviderState(
    generalPractitionerInSumperk,
    isVisible: true,
  );

  await findDoctorPage.clickSearchField();
  await doctorSearchDetailPage.verifyScreenIsShown();
  doctorSearchDetailPage
    ..verifySearchResultCount(expectedCount: 2)
    ..verifySearchHistoryVisibilityState(isShown: true);
}
