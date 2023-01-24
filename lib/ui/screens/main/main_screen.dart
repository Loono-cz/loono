import 'dart:async';
import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:loono/repositories/user_repository.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/router/notification_router.dart';
import 'package:loono/services/examinations_service.dart';
import 'package:loono/services/webview_service.dart';
import 'package:loono/ui/widgets/bottom_navigation_builder.dart';
import 'package:loono/ui/widgets/no_connection_message.dart';
import 'package:loono/ui/widgets/notification_loading_widget.dart';
import 'package:loono/utils/donate_utils.dart';
import 'package:loono/utils/registry.dart';
import 'package:provider/provider.dart';

/// Post-auth main screen.
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, this.notificationRouter}) : super(key: key);

  final NotificationRouter? notificationRouter;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final Connectivity _connectivity = Connectivity();

  bool connectivityLocked = true;

  final analyticsTabNames = ['PreventionTab', 'FindDoctorTab', 'ExploreSectionTab'];

  Flushbar? _noConnectionMessage;

  late NotificationScreen open = widget.notificationRouter?.screen ?? NotificationScreen.main;

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
    final examinationsProvider = Provider.of<ExaminationsProvider>(context, listen: false);
    if (!Platform.isIOS) {
      checkAndShowDonatePage(context, mounted: mounted);
    }
    registry.get<UserRepository>().sync();

    _connectivity.checkConnectivity().then(evalConnectivity);
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      evalConnectivity(result);

      /// re-evaluate connection status after network reconnection
      if (result != ConnectivityResult.none && !examinationsProvider.loading) {
        examinationsProvider.fetchExaminations();
      }
    });

    widget.notificationRouter?.addListener(() {
      setState(() {
        open = NotificationScreen.main;
      });
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _noConnectionMessage ??= noConnectionFlushbar(context: context);
    final hasNotification =
        context.select<ExaminationsProvider, bool>((state) => state.hasNotification);

    return open == NotificationScreen.main
        ? WillPopScope(
            /// index 2 has its own WillPopScope for webview navigation. This prevents pop event override
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
                PreventionRoute(),
                FindDoctorRoute(),
                AboutHealthRoute(),
              ],
              bottomNavigationBuilder: (_, tabsRouter) {
                return bottomNavigationBuilder(
                  context,
                  tabsRouter,
                  analyticsTabNames,
                  hasNotification: hasNotification,
                );
              },
            ),
          )
        : NotificationLoadingWidget(screen: open);
  }
}
