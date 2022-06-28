import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:stack_trace/stack_trace.dart';

extension LogExt on Object {
  void logTestEvent([String? event]) {
    if (event != null) {
      logCustomTestEvent('$runtimeType: $event');
    } else {
      final stackTraceMethodCall = Trace.current(1).frames.firstOrNull?.member;
      logCustomTestEvent(stackTraceMethodCall ?? '$runtimeType: unknown action method call');
    }
  }
}

void logCustomTestEvent(String event) => debugPrint('[E2E_TEST] $event');

void logTestStart(String testCaseName) => logCustomTestEvent('Starting TC: "$testCaseName"');
