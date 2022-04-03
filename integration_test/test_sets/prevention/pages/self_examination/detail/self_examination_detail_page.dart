import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/screens/prevention/self_examination/detail_screen.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/widget_expansion_tile.dart';

import '../../../../../test_helpers/find_text_span.dart';
import '../../../../../test_helpers/widget_tester_extensions.dart';

/// * Corresponding screen: [SelfExaminationDetailScreen]
class SelfExaminationDetailPage {
  SelfExaminationDetailPage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder backBtn = find.byKey(const Key('selfExaminationDetailPage_backBtn'));
  final Finder headerText = find.byKey(const Key('selfExaminationDetailPage_text_header'));
  final Finder intervalText = find.byKey(const Key('selfExaminationDetailPage_text_interval'));
  final Finder image = find.byKey(const Key('selfExaminationDetailPage_image'));
  final Finder rewardProgressArea =
      find.byKey(const Key('selfExaminationDetailPage_rewardProgressArea'));
  final Finder selfExamPerformedBtn =
      find.byKey(const Key('selfExaminationDetailPage_button_selfExamPerformed'));
  final Finder howToSelfExamBtn =
      find.byKey(const Key('selfExaminationDetailPage_button_howToSelfExam'));
  final Finder faqSection = find.byKey(const Key('selfExaminationDetailPage_faqSection'));
  final Finder faqAnswer = find.byKey(const Key('widgetExpansionTile_answer'));

  Finder getSelfFaqItem(int itemPosition) =>
      find.byKey(ValueKey('selfFaqSection_item_${itemPosition - 1}'));

  // icon is tappable
  Finder getSelfFaqItemIcon(int itemPosition) =>
      find.byKey(ValueKey('selfFaqSection_item_expansionIcon_${itemPosition - 1}'));

  /// Page methods
  Future<void> clickBackButton() async {
    logTestEvent();
    await tester.ensureVisible(backBtn);
    await tester.pumpAndSettle();
    await tester.tap(backBtn);
    await tester.pumpAndSettle();
  }

  Future<void> clickSelfExaminationPerformedButton() async {
    logTestEvent();
    await tester.tap(selfExamPerformedBtn);
    await tester.pumpAndSettle();
  }

  Future<void> clickHowToSelfExamButton() async {
    logTestEvent();
    await tester.tap(howToSelfExamBtn);
    await tester.pumpAndSettle();
  }

  Future<void> clickSelfExamFaqItem({required int itemPosition}) async {
    logTestEvent('Click on "$itemPosition. SelfFaqItem"');
    final faqItem = getSelfFaqItem(itemPosition);
    final faqItemIcon = getSelfFaqItemIcon(itemPosition);
    await tester.ensureVisible(faqItem);
    await tester.pumpAndSettle();
    await tester.tap(faqItemIcon, warnIfMissed: false);
    await tester.pumpAndSettle();
  }

  Future<void> verifySelfExamFaqContentIsExpanded({required int itemPosition}) async {
    logTestEvent('Verify "$itemPosition. SelfExamFaq" is expanded');
    final faqItem = getSelfFaqItem(itemPosition);
    await tester.ensureVisible(faqItem);
    await tester.pumpAndSettle();
    expect(
      find.descendant(
        of: faqItem,
        matching: faqAnswer,
      ),
      findsWidgets,
    );
  }

  Future<void> verifySelfExamFaqContentIsCollapsed({required int itemPosition}) async {
    logTestEvent('Verify "$itemPosition. SelfExamFaq" is collapsed');
    final faqItem = getSelfFaqItem(itemPosition);
    await tester.ensureVisible(faqItem);
    await tester.pumpAndSettle();
    expect(
      find.descendant(
        of: faqItem,
        matching: faqAnswer,
      ),
      findsNothing,
    );
  }

  Future<void> clickAtFaqContentText({
    required int itemPosition,
    required String text,
  }) async {
    logTestEvent('Click "$itemPosition. SelfExamFaq" on text: "$text"');
    final faqItem = getSelfFaqItem(itemPosition);
    await tester.ensureVisible(faqItem);
    await tester.pumpAndSettle();
    final richTexts = find.descendant(
      of: faqItem,
      matching: find.byType(RichText),
    );
    for (final richText in richTexts.evaluate()) {
      await fireOnTap(tester, richText, text);
    }
  }

  void verifySelfExaminationPerformedButtonText(String expectedText) {
    logTestEvent('Verify "self examination performed button" text is: "$expectedText"');
    expect(
      find.descendant(
        of: selfExamPerformedBtn,
        matching: find.text(expectedText),
      ),
      findsOneWidget,
    );
  }

  void verifySelfExaminationPerformedButtonState({required bool isEnabled}) {
    if (isEnabled) {
      logTestEvent('Verify "self examination performed button" state is enabled');
    } else {
      logTestEvent('Verify "self examination performed button" state is disabled');
    }
    expect(
      tester.widget<LoonoButton>(selfExamPerformedBtn).enabled,
      isEnabled,
    );
  }

  void verifyHeaderText(String expectedHeader) {
    logTestEvent('Verify "header" text is: "$expectedHeader"');
    expect(tester.widget<Text>(headerText).data, expectedHeader);
  }

  void verifyIntervalText(String expectedInterval) {
    logTestEvent('Verify "interval" text is: "$expectedInterval"');
    expect(tester.widget<Text>(intervalText).data, expectedInterval);
  }

  void verifyImageIsShown() {
    logTestEvent();
    expect(image, findsOneWidget);
  }

  void verifyRewardProgressBarIsShown() {
    logTestEvent();
    expect(rewardProgressArea, findsOneWidget);
  }

  void verifyFaqSectionIsShown() {
    logTestEvent();
    expect(faqSection, findsOneWidget);
  }

  void verifyFaqQuestionsAreShown() {
    logTestEvent();
    expect(
      find.descendant(
        of: faqSection,
        matching: find.byType(WidgetExpansionTile),
      ),
      findsWidgets,
    );
  }

  Future<void> verifyScreenIsShown() async {
    logTestEvent();
    await tester.pumpUntilVisible(find.byType(SelfExaminationDetailScreen));
  }
}
