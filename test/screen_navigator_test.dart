import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:loono/screens/screen_navigator.dart';

class _NavigationTestScreen extends StatelessWidget {
  static Page<Object> buildPage(String name) {
    return MaterialPage(
      key: ValueKey(name),
      name: name,
      child: _NavigationTestScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}

void main() {
  testWidgets('ScreenOne should be the top of the stack', (tester) async {
    final screenNavigatorKey = GlobalKey<ScreenNavigatorState>();

    await tester.pumpWidget(
      MaterialApp(
        home: ScreenNavigator(
          key: screenNavigatorKey,
          initialPages: [
            _NavigationTestScreen.buildPage('ScreenOne'),
          ],
        ),
      ),
    );

    final navigator = screenNavigatorKey.currentState!;

    expect(navigator.isTopOfStack('ScreenOne'), true);
  });

  testWidgets('ScreenOne should NOT be the top of the stack', (tester) async {
    final screenNavigatorKey = GlobalKey<ScreenNavigatorState>();

    await tester.pumpWidget(
      MaterialApp(
        home: ScreenNavigator(
          key: screenNavigatorKey,
          initialPages: [
            _NavigationTestScreen.buildPage('ScreenOne'),
            _NavigationTestScreen.buildPage('ScreenTwo'),
          ],
        ),
      ),
    );

    final navigator = screenNavigatorKey.currentState!;

    expect(navigator.isTopOfStack('ScreenOne'), false);
    expect(navigator.isInStack('ScreenOne'), true);
  });

  testWidgets('ScreenTwo should be pushed on the stack', (tester) async {
    final screenNavigatorKey = GlobalKey<ScreenNavigatorState>();

    await tester.pumpWidget(
      MaterialApp(
        home: ScreenNavigator(
          key: screenNavigatorKey,
          initialPages: [
            _NavigationTestScreen.buildPage('ScreenOne'),
          ],
        ),
      ),
    );

    final navigator = screenNavigatorKey.currentState!;

    expect(navigator.isTopOfStack('ScreenTwo'), false);
    expect(navigator.isInStack('ScreenTwo'), false);

    navigator.push(_NavigationTestScreen.buildPage('ScreenTwo'));

    expect(navigator.isTopOfStack('ScreenTwo'), true);
    expect(navigator.isInStack('ScreenTwo'), true);
  });

  testWidgets('ScreenTwo should be popped from the stack', (tester) async {
    final screenNavigatorKey = GlobalKey<ScreenNavigatorState>();

    await tester.pumpWidget(
      MaterialApp(
        home: ScreenNavigator(
          key: screenNavigatorKey,
          initialPages: [
            _NavigationTestScreen.buildPage('ScreenOne'),
            _NavigationTestScreen.buildPage('ScreenTwo'),
          ],
        ),
      ),
    );

    final navigator = screenNavigatorKey.currentState!;

    expect(navigator.isTopOfStack('ScreenTwo'), true);
    expect(navigator.isInStack('ScreenTwo'), true);

    navigator.pop();

    expect(navigator.isTopOfStack('ScreenTwo'), false);
    expect(navigator.isInStack('ScreenTwo'), false);
  });
}
