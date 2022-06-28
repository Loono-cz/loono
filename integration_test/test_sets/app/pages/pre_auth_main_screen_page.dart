import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/screens/main/pre_auth/pre_auth_main_screen.dart';

import '../../../test_helpers/common_finders.dart';
import '../../../test_helpers/e2e_action_logging.dart';
import '../../../test_helpers/widget_tester_extensions.dart';

/// * Corresponding screen: [PreAuthMainScreen]
class PreAuthMainScreenPage with MainScreenFinders {
  PreAuthMainScreenPage(this.tester);

  final WidgetTester tester;

  /// Page finders
  Finder get preventionBottomNavItem => commonPreventionBottomNavItem;

  Finder get findDoctorBottomNavItem => commonFindDoctorBottomNavItem;

  Finder get aboutHealthBottomNavItem => commonAboutHealthBottomNavItem;

  /// Page methods
  Future<void> clickPreventionTab() async {
    logTestEvent();
    await tester.tap(preventionBottomNavItem);
    await tester.pumpAndSettle();
  }

  Future<void> clickFindDoctorTab() async {
    logTestEvent();
    await tester.tap(findDoctorBottomNavItem);
    await tester.pumpAndSettle();
  }

  Future<void> clickAboutHealthTab() async {
    logTestEvent();
    await tester.tap(aboutHealthBottomNavItem);
    await tester.pumpAndSettle();
  }

  Future<void> verifyScreenIsShown() async {
    logTestEvent();
    await tester.pumpUntilFound(find.byType(PreAuthMainScreen));
  }
}
