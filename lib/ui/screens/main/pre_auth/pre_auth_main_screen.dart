import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/webview_service.dart';
import 'package:loono/ui/widgets/bottom_navigation_builder.dart';
import 'package:loono/ui/widgets/no_connection_message.dart';
import 'package:provider/provider.dart';

/// Pre-auth main screen.
class PreAuthMainScreen extends StatefulWidget {
  const PreAuthMainScreen({
    Key? key,
    this.overridenPreventionRoute,
  }) : super(key: key);

  final PageRouteInfo? overridenPreventionRoute;

  @override
  State<PreAuthMainScreen> createState() => _PreAuthMainScreenState();
}

class _PreAuthMainScreenState extends State<PreAuthMainScreen> {
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final Connectivity _connectivity = Connectivity();
  Flushbar? _noConnectionMessage;

  static const analyticsTabNames = [
    'PreAuthPreventionTab',
    'PreAuthFindDoctorTab',
    'PreAuthExploreSectionTab'
  ];

  void evalConnectivity(ConnectivityResult result) {
    if (result == ConnectivityResult.none && (_noConnectionMessage?.isShowing() == false)) {
      _noConnectionMessage?.show(context);
    } else if (result != ConnectivityResult.none && (_noConnectionMessage?.isShowing() ?? false)) {
      _noConnectionMessage?.dismiss();
    }
  }

  @override
  void initState() {
    super.initState();

    _connectivity.checkConnectivity().then(evalConnectivity);
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(evalConnectivity);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _noConnectionMessage ??= noConnectionFlushbar(context: context, isPreAuth: true);

    return WillPopScope(
      onWillPop: () async {
        final webViewController = context.read<WebViewProvider>().webViewController;
        if (AutoRouter.of(context).isRouteActive(AboutHealthRoute.name) &&
            webViewController != null &&
            await webViewController.canGoBack()) {
          await webViewController.goBack();
        }
        return false;
      },
      child: AutoTabsScaffold(
        routes: [
          PreAuthPreventionWrapperRoute(forceRoute: widget.overridenPreventionRoute),
          FindDoctorRoute(),
          AboutHealthRoute(),
        ],
        bottomNavigationBuilder: (_, tabsRouter) {
          return bottomNavigationBuilder(
                  context,
                  tabsRouter,
                  analyticsTabNames,
                );
        },
      ),
    );
  }
}
