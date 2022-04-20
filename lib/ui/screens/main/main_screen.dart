import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/repositories/user_repository.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/examinations_service.dart';
import 'package:loono/ui/widgets/custom_navigation_bar.dart';
import 'package:loono/ui/widgets/no_connection_message.dart';
import 'package:loono/utils/registry.dart';
import 'package:provider/provider.dart';

/// Post-auth main screen.
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int? _selectedIndex;
  StreamSubscription? subscription;

  bool connectivityLocked = true;

  final analyticsTabNames = ['PreventionTab', 'FindDoctorTab', 'ExploreSectionTab'];

  final noConnectionMessage = noConnectionFlushbar();

  void evalConnectivity(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      noConnectionMessage.show(context);
    } else {
      noConnectionMessage.dismiss(context);
    }
  }

  @override
  void initState() {
    super.initState();
    final examinationsProvider = Provider.of<ExaminationsProvider>(context, listen: false);

    WidgetsBinding.instance?.addPostFrameCallback(
      (_) => examinationsProvider.fetchExaminations(),
    );
    registry.get<UserRepository>().sync();

    /// lock connectivity for the first 300ms to prevent multiple api calls on init
    Future<void>.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        connectivityLocked = false;
      });
    });

    Connectivity().checkConnectivity().then(
          evalConnectivity,
        );

    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      evalConnectivity(result);

      /// fetch examinations after network reconnection
      if (result != ConnectivityResult.none &&
          examinationsProvider.examinations == null &&
          !connectivityLocked) {
        examinationsProvider.fetchExaminations();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      /// index 2 has its own WillPopScope for webview navigation. This prevents pop event override
      onWillPop: _selectedIndex == 2 ? null : () async => false,
      child: AutoTabsScaffold(
        routes: [
          PreventionRoute(),
          FindDoctorRoute(),
          AboutHealthRoute(),
        ],
        bottomNavigationBuilder: (_, tabsRouter) {
          return CustomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: (index) async {
              await registry
                  .get<FirebaseAnalytics>()
                  .setCurrentScreen(screenName: analyticsTabNames[index]);
              tabsRouter.setActiveIndex(index);
              setState(() {
                _selectedIndex = index;
              });
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
