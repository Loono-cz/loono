import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/widgets/custom_navigation_bar.dart';

import '../../../test_helpers/widget_tester_extensions.dart';

class PreAuthMainScreenPage {
  PreAuthMainScreenPage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder preventionBottomNavItem = find.descendant(
    of: find.byType(CustomNavigationBar),
    matching: find.text('Prevence'),
  );
  final Finder findDoctorBottomNavItem = find.descendant(
    of: find.byType(CustomNavigationBar),
    matching: find.text('Najít lékaře'),
  );
  final Finder aboutHealthBottomNavItem = find.descendant(
    of: find.byType(CustomNavigationBar),
    matching: find.text('O zdraví'),
  );

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
}
