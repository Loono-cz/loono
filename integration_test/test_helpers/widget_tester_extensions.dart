import 'package:another_flushbar/flushbar.dart';
import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stack_trace/stack_trace.dart';

const _defaultTimeout = Duration(seconds: 6);

/// Common controls that can be reused across tests and are not specific for a single page.
///
/// Example use cases: waiting for a Toast message to disappear, doing a pull-to-refresh, ...
extension CommonControlsExt on WidgetTester {
  Future<void> waitForToastToDisappear({String? msgPattern}) async {
    msgPattern == null
        ? debugPrint('Waiting for Toast to disappear')
        : debugPrint('Waiting for Toast with message "$msgPattern" to disappear');
    final flushbar = find.byType(Flushbar);
    final flushbarMsg = msgPattern == null
        ? flushbar
        : find.descendant(
            of: flushbar,
            matching: find.textContaining(RegExp(msgPattern, caseSensitive: false)),
          );
    await pumpUntilFound(flushbarMsg, failOnTimeout: msgPattern != null);
    await pumpUntilNotFound(flushbar);
  }
}

extension WidgetTesterExt on WidgetTester {
  Future<void> pumpSettleAndWait({int seconds = 2}) async {
    await pumpAndSettle();
    await pump(Duration(seconds: seconds));
  }

  Future<void> pumpUntilNotFound(
    Finder finder, {
    Duration timeout = _defaultTimeout,
    bool failOnTimeout = true,
  }) async {
    await _pumpUntil(finder, timeout: timeout, failOnTimeout: failOnTimeout, untilFound: false);
  }

  Future<void> pumpUntilFound(
    Finder finder, {
    Duration timeout = _defaultTimeout,
    bool failOnTimeout = true,
  }) async {
    await _pumpUntil(finder, timeout: timeout, failOnTimeout: failOnTimeout);
  }

  Future<void> _pumpUntil(
    Finder finder, {
    required Duration timeout,
    required bool failOnTimeout,
    bool untilFound = true,
  }) async {
    const pumpWaitInMillisecs = 200;
    var timeOutInMillisecs = timeout.inMilliseconds;
    assert(timeOutInMillisecs >= 0);
    while (true) {
      if (untilFound && widgetList(finder).isNotEmpty) {
        break;
      } else if (!untilFound && widgetList(finder).isEmpty) {
        break;
      }
      await pump(const Duration(milliseconds: pumpWaitInMillisecs));
      timeOutInMillisecs -= pumpWaitInMillisecs;
      if (timeOutInMillisecs < 0) {
        if (failOnTimeout) {
          throw Exception(
            '${untilFound ? 'pumpUntilFound' : 'pumpUntilNotFound'} of finder "${finder.toString()}" has timeouted',
          );
        } else {
          break;
        }
      }
    }
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
