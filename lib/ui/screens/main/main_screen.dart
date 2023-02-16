import 'dart:async';
import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/repositories/user_repository.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/examinations_service.dart';
import 'package:loono/services/webview_service.dart';
import 'package:loono/ui/widgets/custom_navigation_bar.dart';
import 'package:loono/ui/widgets/no_connection_message.dart';
import 'package:loono/utils/donate_utils.dart';
import 'package:loono/utils/registry.dart';
import 'package:provider/provider.dart';

/// Post-auth main screen.
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final Connectivity _connectivity = Connectivity();

  bool connectivityLocked = true;

  final analyticsTabNames = ['PreventionTab', 'FindDoctorTab', 'ExploreSectionTab'];

  Flushbar? _noConnectionMessage;

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

    /// Initialize connectivity status and examinations
    _connectivity.checkConnectivity().then((ConnectivityResult result) {
      evalConnectivity(result);
      if (result != ConnectivityResult.none) {
        examinationsProvider.fetchExaminations();
      }
    });

    /// Set-up connectivity listener
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      evalConnectivity(result);

      /// re-evaluate connection status after network reconnection
      if (result != ConnectivityResult.none && !examinationsProvider.loading) {
        examinationsProvider.fetchExaminations();
      }
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

    return WillPopScope(
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
          return CustomNavigationBar(
            key: const Key('mainScreenPage_bottomNavBar'),
            currentIndex: tabsRouter.activeIndex,
            onTap: (index) async {
              await registry.get<FirebaseAnalytics>().setCurrentScreen(
                    screenName: analyticsTabNames[index],
                  );
              tabsRouter.setActiveIndex(index);
            },
            items: [
              CustomNavigationBarItem(
                hasNotification: hasNotification,
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
