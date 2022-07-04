import 'package:charlatan/charlatan.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:loono/helpers/simple_health_care_provider_helper.dart';
import 'package:loono/ui/widgets/find_doctor/search_doctor_card.dart';

import '../../../setup.dart' as app;
import '../../../test_helpers/map_test_utils.dart';
import '../../app/flows/login_flow.dart';
import '../../app/pages/post_auth_main_screen_page.dart';
import '../pages/doctor_search_detail_page.dart';
import '../pages/find_doctor_page.dart';
import '../test_data/base_doctor_test_data.dart';

/// Test case link description:
/// Choosing a specialization should show only relevant doctors.
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
      generalPractitionerInSumperk,
      dermatologistInSumperk2ndFloor,
      dentistInPrague,
    ],
  );

  final mainPage = PostAuthMainScreenPage(tester);
  final findDoctorPage = FindDoctorPage(tester);
  final doctorSearchDetailPage = DoctorSearchDetailPage(tester);

  await mainPage.clickFindDoctorTab();
  await findDoctorPage.verifyScreenIsShown();
  await findDoctorPage.verifyControlComponentsAreShown();

  await findDoctorPage.verifyDoctorSheetVisibilityState(isShown: true);
  findDoctorPage.verifyDoctorsCountInSheet(expectedCount: 3);
  await findDoctorPage.verifyVisibleAreaProviderState(dentistInPrague, isVisible: true);

  // There are total of 2 doctors in Šumperk.
  await findDoctorPage.animateToLocation(
    latLng: generalPractitionerInSumperk.latLng,
    locationName: 'Šumperk',
  );
  await findDoctorPage.verifyDoctorSheetVisibilityState(isShown: true);
  findDoctorPage.verifyDoctorsCountInSheet(expectedCount: 2);
  await findDoctorPage.verifyVisibleAreaProviderState(dentistInPrague, isVisible: false);

  await findDoctorPage.clickSearchField();
  await doctorSearchDetailPage.verifyScreenIsShown();

  await doctorSearchDetailPage.insertSearchText('Pra');
  doctorSearchDetailPage.verifySearchResultCount(expectedCount: 2);

  await doctorSearchDetailPage.insertSearchText('Prakt');
  doctorSearchDetailPage.verifySearchResultCount(expectedCount: 1);

  // There is only 1 doctor as general practitioner in Šumperk.
  await doctorSearchDetailPage.clickSpecializationChip(position: 1);
  await findDoctorPage.verifyDoctorSheetVisibilityState(isShown: true);
  findDoctorPage.verifyDoctorsCountInSheet(expectedCount: 1);
  await findDoctorPage.dragSheetUp();
  final doctorCard = tester.widget<SearchDoctorCard>(
    findDoctorPage.getDoctorCardById(generalPractitionerInSumperk.uniqueId),
  );
  expect(doctorCard.item.category, contains(contains(generalPractitionerInSumperk.category.first)));

  // Clearing specialization should show all doctors again.
  await tester.pump(const Duration(seconds: 2));
  await findDoctorPage.clickClearSpecialization();
  await findDoctorPage.verifyDoctorSheetVisibilityState(isShown: true);
  findDoctorPage.verifyDoctorsCountInSheet(expectedCount: 2);
}
