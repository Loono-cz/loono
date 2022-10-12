import 'dart:async';
import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_sdk/flutter_facebook_sdk.dart';
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
  StreamSubscription? subscription;

  bool connectivityLocked = true;

  final analyticsTabNames = ['PreventionTab', 'FindDoctorTab', 'ExploreSectionTab'];

  Flushbar? noConnectionMessage;

  String _deepLinkUrl = 'Unknown';
  FlutterFacebookSdk? facebookDeepLinks;
  bool isAdvertisingTrackingEnabled = true;

  Future<void> initPlatformState() async {
    String? deepLinkUrl;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      facebookDeepLinks = FlutterFacebookSdk();
      facebookDeepLinks!.onDeepLinkReceived!.listen((event) {
        setState(() {
          _deepLinkUrl = event;
        });
      });
      deepLinkUrl = await facebookDeepLinks!.getDeepLinkUrl;
      setState(() {
        _deepLinkUrl = deepLinkUrl!;
      });
    } on PlatformException {
      print;
    }
    if (!mounted) return;
  }

  Future<void> logActivateApp() async {
    await facebookDeepLinks?.setAdvertiserTracking(isEnabled: isAdvertisingTrackingEnabled);
    final isInitializedSdk = await facebookDeepLinks!.initializeSDK();
    if (isInitializedSdk) {
      print('initialized');
    }
    final isAppActivated = await facebookDeepLinks!.logActivateApp();
    if (isAppActivated) {
      print('activated');
    }
  }

  Future<void> logEvent({
    required String eventName,
    double? valueToSum,
    dynamic? parameters,
  }) async {
    final result = await facebookDeepLinks!
        .logEvent(eventName: eventName, parameters: parameters, valueToSum: valueToSum);
    print('LogEvent $result');
  }

  void evalConnectivity(ConnectivityResult result) {
    /// TEMP: od not show 'no connection' flushbar -> randomly shows bcs of unknown bug
    // if (result == ConnectivityResult.none && noConnectionMessage?.isShowing() == false) {
    //   noConnectionMessage?.show(context);
    // } else if (noConnectionMessage?.isDismissed() == false) {
    //   noConnectionMessage?.dismiss(context);
    // }
  }

  @override
  void initState() {
    super.initState();
    final examinationsProvider = Provider.of<ExaminationsProvider>(context, listen: false);
    if (!Platform.isIOS) {
      checkAndShowDonatePage(context, mounted: mounted);
    }
    registry.get<UserRepository>().sync();

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await initPlatformState();

      await logActivateApp();

      await logEvent(eventName: 'MainScreen');

      subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
        evalConnectivity(result);

        /// re-evaluate connection status after network reconnection
        if (result != ConnectivityResult.none && !examinationsProvider.loading) {
          examinationsProvider.fetchExaminations();
        }
      });
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    noConnectionMessage ??= noConnectionFlushbar(context: context);
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
              await registry
                  .get<FirebaseAnalytics>()
                  .setCurrentScreen(screenName: analyticsTabNames[index]);
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
