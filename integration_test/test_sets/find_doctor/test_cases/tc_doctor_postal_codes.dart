import 'package:charlatan/charlatan.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:loono/ui/widgets/find_doctor/search_result_list_item.dart';

import '../../../setup.dart' as app;
import '../../../test_helpers/dart_objects_gens.dart';
import '../../app/flows/login_flow.dart';
import '../../app/pages/post_auth_main_screen_page.dart';
import '../pages/doctor_search_detail_page.dart';
import '../pages/find_doctor_page.dart';

part '../test_data/tc_postal_codes_test_data.dart';

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
      _mikulovice1,
      _mikulovice2Close,
      _mikulovice3VeryFar,
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

  await doctorSearchDetailPage.insertSearchText('Mikul');
  doctorSearchDetailPage.verifySearchResultCount(expectedCount: 2);

  final firstResultItem =
      tester.widget<SearchResultListItem>(doctorSearchDetailPage.getSearchResultItemByIndex(0));
  final secondResultItem =
      tester.widget<SearchResultListItem>(doctorSearchDetailPage.getSearchResultItemByIndex(1));
  expect(
    firstResultItem.searchResult.overriddenText,
    anyOf('Mikulovice (671 33)', 'Mikulovice (671 34)'),
  );
  expect(
    secondResultItem.searchResult.overriddenText,
    'Mikulovice (790 84)',
  );
}
