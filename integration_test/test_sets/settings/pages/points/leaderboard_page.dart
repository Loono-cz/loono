import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../test_helpers/common_finders.dart';
import '../../../../test_helpers/widget_tester_extensions.dart';

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
}
