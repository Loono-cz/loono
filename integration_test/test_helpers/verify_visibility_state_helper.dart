import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

import 'e2e_action_logging.dart';
import 'widget_tester_extensions.dart';

typedef VerifyVisibilityState = FutureOr<void> Function({required bool isShown});

mixin VerifyVisibilityStateHelper on Object {
  /// Pass [widgetTester] if the expected widget may take some time to show up.
  VerifyVisibilityState getVerifyVisibilityStateFunction({
    required Finder finder,
    required String widgetName,
    WidgetTester? widgetTester,
  }) =>
      widgetTester != null
          ? ({required bool isShown}) async {
              if (isShown) {
                logTestEvent('Verify "$widgetName" is shown');
                await widgetTester.pumpUntilFound(finder);
              } else {
                logTestEvent('Verify "$widgetName" is not shown');
                await widgetTester.pumpUntilNotFound(finder);
              }
            }
          : ({required bool isShown}) {
              if (isShown) {
                logTestEvent('Verify "$widgetName" is shown');
                expect(finder, findsOneWidget);
              } else {
                logTestEvent('Verify "$widgetName" is not shown');
                expect(finder, findsNothing);
              }
            };
}
