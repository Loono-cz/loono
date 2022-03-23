import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stack_trace/stack_trace.dart';

extension WidgetTesterExt on WidgetTester {
  Future<void> pumpSettleAndWait({int seconds = 2}) async {
    await pumpAndSettle();
    await pump(Duration(seconds: seconds));
  }

  Future<void> pumpUntilNotVisible(
    Finder finder, {
    Duration timeout = const Duration(seconds: 20),
  }) async {
    await _pumpUntil(finder, timeout: timeout, untilVisible: false);
  }

  Future<void> pumpUntilVisible(
    Finder finder, {
    Duration timeout = const Duration(seconds: 20),
  }) async {
    await _pumpUntil(finder, timeout: timeout);
  }

  Future<void> _pumpUntil(
    Finder finder, {
    required Duration timeout,
    bool untilVisible = true,
  }) async {
    const pumpWaitInMillisecs = 200;
    var timeOutInMillisecs = timeout.inMilliseconds;
    assert(timeOutInMillisecs >= 0);
    while (true) {
      if (untilVisible && widgetList(finder).isNotEmpty) {
        break;
      } else if (!untilVisible && widgetList(finder).isEmpty) {
        break;
      }
      await pump(const Duration(milliseconds: pumpWaitInMillisecs));
      timeOutInMillisecs -= pumpWaitInMillisecs;
      if (timeOutInMillisecs < 0) {
        throw Exception(
          '${untilVisible ? 'pumpUntilVisible' : 'pumpUntilNotVisible'} of finder "${finder.toString()}" has timeouted',
        );
      }
    }
    await pump(const Duration(seconds: 1));
  }
}

extension LogExt on Object {
  void logTestEvent([String? event]) {
    if (event != null) {
      debugPrint('$runtimeType: $event');
    } else {
      final stackTraceMethodCall = Trace.current(1).frames.firstOrNull?.member;
      debugPrint(stackTraceMethodCall ?? '$runtimeType: unknown method');
    }
  }
}
