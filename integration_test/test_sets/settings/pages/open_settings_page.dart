import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/screens/settings/open_settings.dart';
import 'package:loono/ui/widgets/button.dart';

import '../../../test_helpers/common_finders.dart';
import '../../../test_helpers/widget_tester_extensions.dart';

/// * Corresponding screen: [OpenSettingsScreen]
class OpenSettingsPage with SettingsFinders {
  OpenSettingsPage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder editProfileBtn = find.widgetWithText(LoonoButton, 'Upravit účet');
  final Finder pointsHelpBtn = find.widgetWithText(LoonoButton, 'Co s body?');
  final Finder leaderboardBtn = find.widgetWithText(LoonoButton, 'Žebříček');

  /// Page methods
  Future<void> clickEditProfileButton() async {
    logTestEvent();
    await tester.tap(editProfileBtn);
    await tester.pumpAndSettle();
  }

  Future<void> clickPointsHelpButton() async {
    logTestEvent();
    await tester.tap(pointsHelpBtn);
    await tester.pumpAndSettle();
  }

  Future<void> clickLeaderboardButton() async {
    logTestEvent();
    await tester.tap(leaderboardBtn);
    await tester.pumpAndSettle();
  }

  Future<void> verifyScreenIsShown() async {
    logTestEvent();
    await tester.pumpUntilFound(find.byType(OpenSettingsScreen));
  }
}
