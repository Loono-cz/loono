import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:loono/utils/app_config.dart';
import 'package:loono/utils/registry.dart';

class AboutHealthScreen extends StatefulWidget {
  const AboutHealthScreen({Key? key}) : super(key: key);

  @override
  State<AboutHealthScreen> createState() => _AboutHealthScreenState();
}

class _AboutHealthScreenState extends State<AboutHealthScreen> {
  InAppWebViewController? webViewController;

  bool _useHybridComposition() {
    final platform = registry.get<AppConfig>().platformVersion;
    if (Platform.isAndroid && platform.contains('Android ')) {
      final version = int.parse(platform.replaceAll('Android ', ''));

      /// use hybrid composition for android api level >= 29 (android 10 +)
      return version >= 29;
    }
    return false;
  }

  Future<bool> _handleBackGesture() async {
    if (webViewController != null && await webViewController!.canGoBack()) {
      await webViewController!.goBack();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _handleBackGesture,
      child: Scaffold(
        body: SafeArea(
          child: InAppWebView(
            onWebViewCreated: (controller) {
              webViewController = controller;
            },
            initialUrlRequest: URLRequest(
              url: Uri.parse('https://loono.cz/rozcestnik-prevence'),
            ),
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                useShouldOverrideUrlLoading: true,
                mediaPlaybackRequiresUserGesture: false,
              ),
              android: AndroidInAppWebViewOptions(
                useHybridComposition: _useHybridComposition(),
              ),
              ios: IOSInAppWebViewOptions(
                allowsInlineMediaPlayback: true,
              ),
            ),
            shouldOverrideUrlLoading: (controller, navigationAction) async {
              final uri = navigationAction.request.url!;

              /// allow only "loono.cz" host and prevent clicks outside of loono.cz
              if (uri.host.contains('loono.cz')) {
                return NavigationActionPolicy.ALLOW;
              }

              return NavigationActionPolicy.CANCEL;
            },
          ),
        ),
      ),
    );
  }
}
