import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/screens/settings/leaderboard.dart';

import '../../../../test_helpers/common_finders.dart';
import '../../../../test_helpers/e2e_action_logging.dart';
import '../../../../test_helpers/widget_tester_extensions.dart';

/// * Corresponding screen: [LeaderboardScreen]
class LeaderboardPage with SettingsFinders {
  LeaderboardPage(this.tester);

  final WidgetTester tester;

  /// Page finders
  Finder get closeBtn => commonSettingsSheetCloseBtn;
  final Finder listTileMeMarker =
      find.byKey(const Key('leaderboardPage_leaderboardTile_isThisMeCircle'));

  /// Page methods
  Future<void> clickCloseButton() async {
    logTestEvent();
    await tester.tap(closeBtn);
    await tester.pumpAndSettle();
  }

  void checkMeMarkerIsDrawn() {
    logTestEvent();
    expect(listTileMeMarker, findsOneWidget);
  }

  Future<void> verifyScreenIsShown() async {
    logTestEvent();
    await tester.pumpUntilFound(find.byType(LeaderboardScreen));
  }
}
