import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loono/helpers/map_variables.dart';
import 'package:loono/services/webview_service.dart';
import 'package:loono/ui/widgets/feedback/feedback_button.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutHealthScreen extends StatelessWidget {
  AboutHealthScreen({Key? key}) : super(key: key);

  final initialUri = Uri.parse('https://www.loono.cz/objevuj-prevenci');

  final allowedUrlsWhitelist = ['www.loono.cz', 'www.youtube.com'];

  final openInBrowserWhitelist = ['spotify.link', 'open.spotify.com', 'www.youtube.com'];

  final _showBackArrow = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          InAppWebView(
            onWebViewCreated: (controller) {
              context.read<WebViewProvider>().setController(controller);
            },
            initialUrlRequest: URLRequest(
              url: initialUri,
            ),
            onUpdateVisitedHistory: (webViewController, uri, androidIsReload) async {
              _showBackArrow.value = uri != initialUri;
            },
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

              if (openInBrowserWhitelist.contains(uri.host) && !uri.path.contains('/embed')) {
                if (await canLaunch(uri.toString())) {
                  await launch(uri.toString());
                }
              }

              /// prevent clicks outside of allowed urls
              if ((allowedUrlsWhitelist.contains(uri.host) && !uri.path.contains('/watch') ||
                  uri.toString().contains('https://open.spotify.com/embed'))) {
                return NavigationActionPolicy.ALLOW;
              }
              return NavigationActionPolicy.CANCEL;
            },
          ),
          ValueListenableBuilder<bool>(
            valueListenable: _showBackArrow,
            builder: (context, value, _) {
              if (value) {
                return Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: IconButton(
                    onPressed: () async {
                      final webViewController = context.read<WebViewProvider>().webViewController;
                      await webViewController?.goBack();
                    },
                    icon: SvgPicture.asset('assets/icons/arrow_back.svg'),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          const Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(top: 8.0, right: 18),
              child: FeedbackButton(),
            ),
          )
        ],
      ),
    );
  }
}
