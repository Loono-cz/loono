import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:loono/main.dart';

void main() {
  testWidgets('Hello world smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.text('Loono'), findsOneWidget);
  });
}
