import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/screens/prevention/prevention_screen.dart';
import 'package:loono/ui/widgets/notification_icon.dart';
import 'package:loono/ui/widgets/settings/avatar.dart';
import 'package:loono_api/loono_api.dart';

import '../../../test_helpers/common_finders.dart';
import '../../../test_helpers/widget_tester_extensions.dart';

class PreventionPage with BadgeFinders {
  PreventionPage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder profileAvatar = find.byType(LoonoAvatar);
  final Finder profileBtnPoints = find.byKey(const Key('profileButton_points'));

  Finder getExaminationCard(ExaminationType type) =>
      find.byKey(ValueKey<ExaminationType>(type), skipOffstage: false);

  Finder getSelfExaminationCard(SelfExaminationType type) =>
      find.byKey(ValueKey<SelfExaminationType>(type), skipOffstage: false);

  Finder getBadge(BadgeType type) => commonGetBadge(type);

  /// Page methods
  Future<void> clickProfileAvatar() async {
    logTestEvent();
    await tester.tap(profileAvatar);
    await tester.pumpAndSettle();
  }

  Future<void> clickExaminationCard(ExaminationType type) async {
    logTestEvent('Clicking ExaminationCard: "${type.name}"');
    final card = getExaminationCard(type);
    await tester.ensureVisible(card);
    await tester.pumpAndSettle();
    await tester.tap(card);
    await tester.pumpAndSettle();
  }

  Future<void> clickSelfExaminationCard(SelfExaminationType type) async {
    logTestEvent('Clicking SelfExaminationCard: "${type.name}"');
    final card = getSelfExaminationCard(type);
    await tester.ensureVisible(card);
    await tester.pumpAndSettle();
    await tester.tap(card);
    await tester.pumpAndSettle();
  }

  Future<void> verifyExaminationCardIsInCategory(
    ExaminationType type, {
    required String expectedCategoryName,
  }) async {
    logTestEvent(
      'Verify ExaminationCard "${type.name}" is in category: "$expectedCategoryName"',
    );
    final card = getExaminationCard(type);
    await tester.ensureVisible(card);
    await tester.pumpAndSettle();
    expect(
      find.ancestor(
        of: card,
        matching: find.text(expectedCategoryName),
      ),
      findsOneWidget,
    );
  }

  Future<void> verifySelfExaminationCardIsInCategory(
    SelfExaminationType type, {
    required String expectedCategoryName,
  }) async {
    logTestEvent(
      'Verify SelfExaminationCard "${type.name}" is in category: "$expectedCategoryName"',
    );
    final card = getSelfExaminationCard(type);
    await tester.ensureVisible(card);
    await tester.pumpAndSettle();
    expect(
      find.ancestor(
        of: card,
        matching: find.byKey(ValueKey<String>('selfExam_category_column_$expectedCategoryName')),
      ),
      findsOneWidget,
    );
  }

  Future<void> verifySelfExaminationCardContainsText(
    SelfExaminationType type, {
    required String textPattern,
  }) async {
    logTestEvent('Verify SelfExaminationCard "${type.name}" contains text: "$textPattern"');
    final card = getSelfExaminationCard(type);
    await tester.ensureVisible(card);
    await tester.pumpAndSettle();
    expect(
      find.descendant(
        of: card,
        matching: find.textContaining(RegExp(textPattern, caseSensitive: false)),
      ),
      findsWidgets,
    );
  }

  Future<void> verifySelfExaminationCardDoesNotHaveNotificationIcon(
    SelfExaminationType type,
  ) async {
    logTestEvent('Verify SelfExaminationCard "${type.name}" does not have "NotificationIcon"');
    final card = getSelfExaminationCard(type);
    await tester.ensureVisible(card);
    await tester.pumpAndSettle();
    expect(
      find.descendant(
        of: card,
        matching: find.byType(NotificationIcon),
      ),
      findsNothing,
    );
  }

  Future<void> verifyScreenIsShown() async {
    logTestEvent();
    await tester.pumpUntilFound(find.byType(PreventionScreen));
  }

  void verifyHasPoints(int expectedPoints) {
    logTestEvent('Verify has points "${expectedPoints.toString()}"');
    final textWidget = tester.widget<Text>(profileBtnPoints);
    expect(textWidget.data, expectedPoints.toString());
  }

  void verifyHasBadge(BadgeType type) {
    logTestEvent('Verify has badge "${type.name}"');
    expect(getBadge(type), findsOneWidget);
  }

  void verifyDoesNotHaveBadge(BadgeType type) {
    logTestEvent('Verify does not have badge "${type.name}"');
    expect(getBadge(type), findsNothing);
  }
}
