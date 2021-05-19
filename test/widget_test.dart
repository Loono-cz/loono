import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loono/core/app_config.dart';

import 'package:loono/screens/home_screen.dart';

void main() {
  testWidgets('Hello world smoke test', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: HomeScreen(
          config: DevConfig(),
        ),
      ),
    );

    expect(find.text('Loono'), findsOneWidget);
  });
}
