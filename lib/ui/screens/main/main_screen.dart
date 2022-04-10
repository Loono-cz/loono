import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/repositories/user_repository.dart';
import 'package:loono/services/examinations_service.dart';
import 'package:loono/services/webview_service.dart';
import 'package:loono/ui/screens/about_health/about_health.dart';
import 'package:loono/ui/screens/find_doctor/find_doctor.dart';
import 'package:loono/ui/screens/prevention/prevention.dart';
import 'package:loono/ui/widgets/custom_navigation_bar.dart';
import 'package:loono/ui/widgets/no_connection_message.dart';
import 'package:loono/utils/registry.dart';
import 'package:provider/provider.dart';

/// Post-auth main screen.
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, this.selectedIndex = 0}) : super(key: key);

  final int selectedIndex;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  StreamSubscription? subscription;

  bool connectivityLocked = true;

  static final List<Widget> _pages = <Widget>[
    PreventionScreen(),
    const FindDoctorScreen(),
    AboutHealthScreen(),
  ];

  final analyticsTabNames = ['PreventionTab', 'FindDoctorTab', 'ExploreSectionTab'];

  Future<void> _onItemTapped(int index) async {
    await registry.get<FirebaseAnalytics>().setCurrentScreen(screenName: analyticsTabNames[index]);

    setState(() => _selectedIndex = index);
  }

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
    _selectedIndex = widget.selectedIndex;
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
      onWillPop: () async {
        final webViewController = context.read<WebViewProvider>().webViewController;
        if (_selectedIndex == 2 &&
            webViewController != null &&
            await webViewController.canGoBack()) {
          await webViewController.goBack();
        }
        return false;
      },
      child: Scaffold(
        body: _pages.elementAt(_selectedIndex),
        bottomNavigationBar: CustomNavigationBar(
          key: const Key('mainScreenPage_bottomNavBar'),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
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
        ),
      ),
    );
  }
}
