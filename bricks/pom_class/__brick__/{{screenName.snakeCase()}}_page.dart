import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// TODO: Implement Page Objects
/// * Corresponding screen: [{{screenName}}Screen]
class {{screenName}}Page {
{{screenName}}Page(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder _somethingOnPage = find.byKey(const Key('page_widget_name'));

  /// Page methods
  {{#hasButton}}
  // ignore: unused_element
  Future<void> _clickSomeButton() async {
    {{#addLogs}}logTestEvent();{{/addLogs}}
    await tester.tap(_somethingOnPage);
    await tester.pumpAndSettle();
  }
  {{/hasButton}}

  Future<void> verifyScreenIsShown() async {
    {{#addLogs}}logTestEvent();{{/addLogs}}
    await tester.pumpUntilFound(find.byType({{screenName}}Screen));
  }
}
