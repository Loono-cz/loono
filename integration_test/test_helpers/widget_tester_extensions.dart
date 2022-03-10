import 'package:flutter_test/flutter_test.dart';

// ignore: constant_identifier_names
const EXEC_MODE = String.fromEnvironment('EXEC_MODE', defaultValue: 'slow');

extension WidgetTesterExt on WidgetTester {
  Future<void> pumpSettleAndWait({
    int seconds = 2,
  }) async {
    final durMillisecs = seconds * 1000;
    final int pumpDurMillisecs;
    if (EXEC_MODE == 'very_slow') {
      pumpDurMillisecs = durMillisecs * 2;
    } else if (EXEC_MODE == 'fast') {
      pumpDurMillisecs = durMillisecs ~/ 4;
    } else if (EXEC_MODE == 'very_fast') {
      pumpDurMillisecs = durMillisecs ~/ 10;
    } else {
      pumpDurMillisecs = durMillisecs;
    }
    await pumpAndSettle();
    await pump(Duration(milliseconds: pumpDurMillisecs));
  }
}
