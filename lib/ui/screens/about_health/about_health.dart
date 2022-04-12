import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:loono/helpers/map_variables.dart';
import 'package:loono/services/webview_service.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutHealthScreen extends StatelessWidget {
  AboutHealthScreen({Key? key}) : super(key: key);

  final initialUri = Uri.parse('https://www.loono.cz/objevuj-prevenci');
  final allowedUrlsWhitelist = ['open.spotify.com', 'www.loono.cz'];
  final openInBrowserWhitelist = ['spotify.link', 'www.youtube.com'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: InAppWebView(
        onWebViewCreated: (controller) {
          context.read<WebViewProvider>().setController(controller);
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
    );
  }
}
