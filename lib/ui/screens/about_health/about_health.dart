import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:loono/helpers/map_variables.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutHealthScreen extends StatefulWidget {
  const AboutHealthScreen({Key? key}) : super(key: key);

  @override
  State<AboutHealthScreen> createState() => _AboutHealthScreenState();
}

class _AboutHealthScreenState extends State<AboutHealthScreen> {
  InAppWebViewController? webViewController;

  final initialUri = Uri.parse('https://www.loono.cz/objevuj-prevenci');
  final initialCss = '#footer {display: none;}'
      '#header {display: none;} '
      '#main {padding-top: 0;}'
      '.preventivka-hero {top: 0;}';
  final allowedUrlsWhitelist = ['open.spotify.com', 'www.loono.cz'];
  final openInBrowserWhitelist = ['spotify.link', 'www.youtube.com'];

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
            onLoadStop: (controller, uri) {
              controller.injectCSSCode(
                source: initialCss,
              );
            },
            initialUrlRequest: URLRequest(
              url: initialUri,
            ),
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                useShouldOverrideUrlLoading: true,
                mediaPlaybackRequiresUserGesture: false,
                userAgent: 'ma-preventivka',
              ),
              android: AndroidInAppWebViewOptions(
                useHybridComposition: useHybridComposition(),
              ),
              ios: IOSInAppWebViewOptions(
                allowsInlineMediaPlayback: true,
              ),
            ),
            shouldOverrideUrlLoading: (controller, navigationAction) async {
              final uri = navigationAction.request.url!;

              if (openInBrowserWhitelist.contains(uri.host)) {
                if (await canLaunch(uri.toString())) {
                  await launch(uri.toString());
                }
              }

              /// prevent clicks outside of allowed urls
              if (allowedUrlsWhitelist.contains(uri.host)) {
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
