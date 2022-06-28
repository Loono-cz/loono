import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/screens/settings/points_help.dart';
import 'package:loono/ui/widgets/button.dart';

import '../../../../test_helpers/common_finders.dart';
import '../../../../test_helpers/e2e_action_logging.dart';
import '../../../../test_helpers/widget_tester_extensions.dart';

/// * Corresponding screen: [PointsHelpScreen]
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

  Future<void> verifyScreenIsShown() async {
    logTestEvent();
    await tester.pumpUntilFound(find.byType(PointsHelpScreen));
  }
}
