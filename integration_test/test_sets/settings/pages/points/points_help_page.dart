import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/widgets/button.dart';

import '../../../../test_helpers/common_shared_finders.dart';

class PointsHelpPage {
  PointsHelpPage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder leaderboardBtn = find.widgetWithText(LoonoButton, 'Žebříček');
  final Finder backBtn = CommonSharedFinders.settingsSheetBackBtn;

  /// Page methods
  Future<void> clickLeaderboardButton() async {
    await tester.tap(leaderboardBtn);
    await tester.pumpAndSettle();
  }

  Future<void> clickBackButton() async {
    await tester.tap(backBtn);
    await tester.pumpAndSettle();
  }
}
