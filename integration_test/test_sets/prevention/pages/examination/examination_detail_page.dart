import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/screens/prevention/examination_detail/examination_detail.dart';
import 'package:loono/ui/screens/prevention/examination_detail/examination_screen.dart';

import '../../../../test_helpers/e2e_action_logging.dart';
import '../../../../test_helpers/widget_tester_extensions.dart';

/// * Corresponding screen: [ExaminationDetailScreen]
class ExaminationDetailPage {
  ExaminationDetailPage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder backBtn = find.byKey(const Key('examinationDetailPage_btn_back'));
  final Finder orderBtn = find.byKey(const Key('examinationDetailPage_btn_order'));
  final Finder addToCalendarBtn = find.byKey(const Key('examinationDetailPage_btn_calendar'));
  final Finder updateDateBtn = find.byKey(const Key('examinationDetailPage_btn_updateDate'));

  /// Page methods
  Future<void> clickBackButton() async {
    logTestEvent();
    await tester.tap(backBtn);
    await tester.pumpAndSettle();
  }

  Future<void> clickOrderButton() async {
    logTestEvent();
    await tester.tap(orderBtn);
    await tester.pumpAndSettle();
  }

  Future<void> clickUpdateDateButton() async {
    logTestEvent();
    await tester.tap(updateDateBtn);
    await tester.pumpAndSettle();
  }

  void verifyOrderButtonIsShown() {
    logTestEvent();
    expect(orderBtn, findsOneWidget);
  }

  void verifyIsFirstAwaitingVisit() {
    logTestEvent();
    expect(find.byKey(const Key('examinationProgress_firstVisitAwaiting')), findsOneWidget);
  }

  void verifyCalendarButtonIsShown() {
    logTestEvent();
    expect(addToCalendarBtn, findsOneWidget);
  }

  Future<void> verifyScreenIsShown() async {
    logTestEvent();
    await tester.pumpUntilFound(find.byType(ExaminationDetail));
  }
}
