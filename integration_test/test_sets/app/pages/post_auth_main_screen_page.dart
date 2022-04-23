import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/screens/main/main_screen.dart';

import '../../../test_helpers/common_finders.dart';
import '../../../test_helpers/widget_tester_extensions.dart';

/// * Corresponding screen: [MainScreen]
class PostAuthMainScreenPage with MainScreenFinders {
  PostAuthMainScreenPage(this.tester);

  final WidgetTester tester;

  /// Page finders
  Finder get preventionBottomNavItem => commonPreventionBottomNavItem;

  Finder get findDoctorBottomNavItem => commonFindDoctorBottomNavItem;

  Finder get aboutHealthBottomNavItem => commonAboutHealthBottomNavItem;

  final Finder bottomNavBar = find.byKey(const Key('mainScreenPage_bottomNavBar'));

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
    await tester.pumpUntilFound(find.byType(MainScreen));
  }

  void verifyBottomBarIsShown() {
    logTestEvent();
    expect(bottomNavBar, findsOneWidget);
  }
}
