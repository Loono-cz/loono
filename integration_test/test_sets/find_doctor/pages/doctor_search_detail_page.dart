import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/screens/find_doctor/doctor_search_detail.dart';
import 'package:loono/ui/widgets/find_doctor/search_results_list.dart';

import '../../../test_helpers/e2e_action_logging.dart';
import '../../../test_helpers/pom_class_helpers.dart';
import '../../../test_helpers/widget_tester_extensions.dart';

/// * Corresponding screen: [DoctorSearchDetailScreen]
class DoctorSearchDetailPage with PomClassHelpers {
  DoctorSearchDetailPage(this.tester);

  final WidgetTester tester;

  final Finder searchTextField =
      find.byKey(const Key('doctorSearchDetailPage_searchTextFormField'));

  Finder getSpecializationByIndex(int index) =>
      find.byKey(ValueKey<String>('searchResultList_specialization_$index'));

  Finder getSearchResultItemByIndex(int index) =>
      find.byKey(ValueKey<String>('searchResultList_item_$index'));

  /// Page finders
  Future<void> insertSearchText(String text) async {
    logTestEvent('Insert search text: "$text"');
    await tester.enterText(searchTextField, text);
    await tester.pumpAndSettle();
    await tester.pump(Duration(milliseconds: (kSearchDebounceDurationMs * 1.25).toInt()));
    await tester.pumpAndSettle();
  }

  Future<void> clickSpecializationChip({required int position}) async {
    logTestEvent('Click on the "$position." specialization chip');
    final chip = getSpecializationByIndex(position - 1);
    await tester.tap(chip);
    await tester.pumpAndSettle();
  }

  Future<void> clickSearchResultItem({required int position}) async {
    logTestEvent('Click on the "$position." search result item');
    final item = getSearchResultItemByIndex(position - 1);
    await tester.tap(item);
    await tester.pumpAndSettle();
  }

  void verifySearchResultCount({required int expectedCount}) {
    logTestEvent('Verify search result item count is: "$expectedCount"');
    final results = tester.widget<SearchResultsList>(find.byType(SearchResultsList));
    expect(results.searchResults.length, expectedCount);
  }

  VerifyVisibilityState get verifySearchHistoryVisibilityState => getVerifyVisibilityStateFunction(
        finder: find.textContaining(RegExp('poslední hledání', caseSensitive: false)),
        widgetName: 'Search history title',
      );

  /// Page methods
  Future<void> verifyScreenIsShown() async {
    logTestEvent();
    await tester.pumpUntilFound(find.byType(DoctorSearchDetailScreen));
  }
}
