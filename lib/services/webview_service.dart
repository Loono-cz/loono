import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewProvider extends ChangeNotifier {
  InAppWebViewController? webViewController;

  void setController(InAppWebViewController controller) {
    webViewController = controller;
    notifyListeners();
  }
}
