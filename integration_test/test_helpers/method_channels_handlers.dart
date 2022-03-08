import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void handleEventChannel(final String name) {
  MethodChannel(name).setMockMethodCallHandler((MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'listen':
        break;
      case 'cancel':
      default:
        return null;
    }
  });
}
