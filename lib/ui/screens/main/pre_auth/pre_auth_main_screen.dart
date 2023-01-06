import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/webview_service.dart';
import 'package:loono/ui/widgets/custom_navigation_bar.dart';
import 'package:loono/ui/widgets/no_connection_message.dart';
import 'package:loono/utils/registry.dart';
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
  StreamSubscription? subscription;
  SnackBar? noConnectionMessage;

  static const analyticsTabNames = [
    'PreAuthPreventionTab',
    'PreAuthFindDoctorTab',
    'PreAuthExploreSectionTab'
  ];

  void evalConnectivity(ConnectivityResult result) {
    /// TEMP: od not show 'no connection' flushbar -> randomly shows bcs of unknown bug
    if (result == ConnectivityResult.none) {
      if (noConnectionMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(noConnectionMessage!);
      }

      //   noConnectionMessage?.show(context);
    } else if (result != ConnectivityResult.none) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();

      // noConnectionMessage?.dismiss();
    }
  }

  @override
  void initState() {
    super.initState();

    Connectivity().checkConnectivity().then(
          evalConnectivity,
        );
    SchedulerBinding.instance.addPostFrameCallback((_) {
      subscription = Connectivity().onConnectivityChanged.listen(evalConnectivity);
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    noConnectionMessage ??= noConnectionFlushbar(context: context, isPreAuth: true);

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
          // TODO: unify widgets with Post-auth MainScreen

          return CustomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: (index) async {
              await registry
                  .get<FirebaseAnalytics>()
                  .setCurrentScreen(screenName: analyticsTabNames[index]);
              tabsRouter.setActiveIndex(index);
            },
            items: [
              CustomNavigationBarItem(
                label: context.l10n.main_menu_item_prevention,
                iconPath: 'assets/icons/tabs/prevention.svg',
                iconPathActive: 'assets/icons/tabs/prevention_active.svg',
              ),
              CustomNavigationBarItem(
                label: context.l10n.main_menu_item_find_doc,
                iconPath: 'assets/icons/tabs/find_doctor.svg',
                iconPathActive: 'assets/icons/tabs/find_doctor_active.svg',
              ),
              CustomNavigationBarItem(
                label: context.l10n.main_menu_item_about_health,
                iconPath: 'assets/icons/tabs/explore.svg',
                iconPathActive: 'assets/icons/tabs/explore_active.svg',
              ),
            ],
          );
        },
      ),
    );
  }
}
