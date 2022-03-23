import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/widgets/button.dart';

import '../../../test_helpers/common_finders.dart';

class OpenSettingsPage with SettingsFinders {
  OpenSettingsPage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder editProfileBtn = find.widgetWithText(LoonoButton, 'Upravit účet');
  final Finder pointsHelpBtn = find.widgetWithText(LoonoButton, 'Co s body?');
  final Finder leaderboardBtn = find.widgetWithText(LoonoButton, 'Žebříček');

  /// Page methods
  Future<void> clickEditProfileButton() async {
    await tester.tap(editProfileBtn);
    await tester.pumpAndSettle();
  }

  Future<void> clickPointsHelpButton() async {
    await tester.tap(pointsHelpBtn);
    await tester.pumpAndSettle();
  }

  Future<void> clickLeaderboardButton() async {
    await tester.tap(leaderboardBtn);
    await tester.pumpAndSettle();
  }
}
