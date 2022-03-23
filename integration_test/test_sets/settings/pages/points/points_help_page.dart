import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/widgets/button.dart';

import '../../../../test_helpers/common_finders.dart';
import '../../../../test_helpers/widget_tester_extensions.dart';

class PointsHelpPage with SettingsFinders {
  PointsHelpPage(this.tester);

  final WidgetTester tester;

  /// Page finders
  Finder get backBtn => commonSettingsSheetBackBtn;
  final Finder leaderboardBtn = find.widgetWithText(LoonoButton, 'Žebříček');

  /// Page methods
  Future<void> clickLeaderboardButton() async {
    logTestEvent();
    await tester.tap(leaderboardBtn);
    await tester.pumpAndSettle();
  }

  Future<void> clickBackButton() async {
    logTestEvent();
    await tester.tap(backBtn);
    await tester.pumpAndSettle();
  }
}
