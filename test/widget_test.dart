import 'package:flutter_test/flutter_test.dart';

import 'package:loono/main.dart';

void main() {
  testWidgets('Hello world smoke test', (tester) async {
    await tester.pumpWidget(
      const MyApp(),
    );

    expect(find.text('Loono'), findsOneWidget);
  });
}
