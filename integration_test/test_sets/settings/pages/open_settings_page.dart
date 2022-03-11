import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/widgets/button.dart';

import '../../../test_helpers/widget_tester_extensions.dart';

class OpenSettingsPage {
  OpenSettingsPage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder editProfileBtn = find.widgetWithText(LoonoButton, 'Upravit účet');
  final Finder aboutPointsBtn = find.widgetWithText(LoonoButton, 'Co s body?');
  final Finder leaderboardBtn = find.widgetWithText(LoonoButton, 'Žebříček');

  /// Page methods
  Future<void> clickEditProfileButton() async {
    await tester.tap(editProfileBtn);
    await tester.pumpSettleAndWait(seconds: 1);
  }

  Future<void> clickAboutPointsButton() async {
    await tester.tap(aboutPointsBtn);
    await tester.pumpSettleAndWait(seconds: 1);
  }

  Future<void> clickLeaderboardButton() async {
    await tester.tap(leaderboardBtn);
    await tester.pumpSettleAndWait(seconds: 1);
  }
}
