import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/screens/force_update.dart';

import '../../../test_helpers/widget_tester_extensions.dart';

/// * Corresponding screen: [ForceUpdateScreen]
class ForceUpdatePage {
  ForceUpdatePage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder forceUpdateBtn = find.byKey(const Key('forceUpdatePage_btn_forceUpdate'));

  /// Page methods
  void verifyForceUpdateButtonIsShown() {
    logTestEvent();
    expect(forceUpdateBtn, findsOneWidget);
  }

  Future<void> verifyScreenIsShown() async {
    logTestEvent();
    await tester.pumpUntilFound(find.byType(ForceUpdateScreen));
  }
}
