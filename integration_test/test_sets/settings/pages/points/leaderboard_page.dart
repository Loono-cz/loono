import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../test_helpers/common_shared_finders.dart';

class LeaderboardPage {
  LeaderboardPage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder listTileMeMarker =
      find.byKey(const Key('leaderboardPage_leaderboardTile_isThisMeCircle'));
  final Finder closeBtn = CommonSharedFinders.settingsSheetCloseBtn;

  /// Page methods
  Future<void> clickCloseButton() async {
    await tester.tap(closeBtn);
    await tester.pumpAndSettle();
  }

  void checkMeMarkerIsDrawn() {
    expect(listTileMeMarker, findsOneWidget);
  }
}
