import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class AboutHealthScreen extends StatelessWidget {
  const AboutHealthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey webViewKey = GlobalKey();
    InAppWebViewController? webViewController;

    final InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ),
    );

    Future<bool> _handleBackGesture() async {
      if (webViewController != null && await webViewController!.canGoBack()) {
        await webViewController!.goBack();
      }
      return false;
    }

    return WillPopScope(
      onWillPop: _handleBackGesture,
      child: Scaffold(
        body: SafeArea(
          child: InAppWebView(
            key: webViewKey,
            onWebViewCreated: (controller) {
              webViewController = controller;
            },
            initialUrlRequest: URLRequest(
              url: Uri.parse('https://loono.cz/rozcestnik-prevence'),
            ),
            initialOptions: options,
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
