// Workaround taken from: https://github.com/flutter/flutter/issues/56023#issuecomment-764985456 by leecommamichael
//
// Flutter issue: https://github.com/flutter/flutter/issues/56023
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

/// Runs the onTap handler for the [TextSpan] which matches the search-string.
///
/// Example usage:
/// ```dart
/// final richTexts = find.descendant(
///   of: faqItem,
///   matching: find.byType(RichText),
/// );
/// for (final richText in richTexts.evaluate()) {
///  fireOnTap(richText, text);
/// }
/// ```
///
/// for single Element: `richTexts.evaluate().first`
Future<void> fireOnTap(WidgetTester tester, Element element, String text) async {
  final paragraph = element.renderObject as RenderParagraph;
  // The children are the individual TextSpans which have TapGestureRecognizers.
  var found = false;
  paragraph.text.visitChildren((dynamic span) {
    if (span.text != text) return true; // continue iterating
    (span.recognizer as TapGestureRecognizer).onTap?.call();
    found = true;
    return false; // stop iterating, we found the one
  });
  if (found) {
    await tester.pumpAndSettle();
  }
}
