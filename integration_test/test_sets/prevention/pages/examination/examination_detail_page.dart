import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/screens/prevention/examination_detail/examination_screen.dart';

import '../../../../test_helpers/widget_tester_extensions.dart';

/// * Corresponding screen: [ExaminationDetailScreen]
class ExaminationDetailPage {
  ExaminationDetailPage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder somethingOnPage = find.byKey(const Key('page_widget_name'));

  /// Page methods

  Future<void> clickSomeButton() async {
    logTestEvent();
    await tester.tap(somethingOnPage);
    await tester.pumpAndSettle();
  }

  Future<void> verifyScreenIsShown() async {
    logTestEvent();
    await tester.pumpUntilFound(find.byType(ExaminationDetailScreen));
  }
}
