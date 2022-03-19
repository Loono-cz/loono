import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/widgets/custom_navigation_bar.dart';

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
    await tester.tap(preventionBottomNavItem);
    await tester.pumpAndSettle();
  }

  Future<void> clickFindDoctorTab() async {
    await tester.tap(findDoctorBottomNavItem);
    await tester.pumpAndSettle();
  }

  Future<void> clickAboutHealthTab() async {
    await tester.tap(aboutHealthBottomNavItem);
    await tester.pumpAndSettle();
  }
}
