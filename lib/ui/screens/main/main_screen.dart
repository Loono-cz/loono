import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/repositories/user_repository.dart';
import 'package:loono/services/examinations_service.dart';
import 'package:loono/ui/screens/about_health/about_health.dart';
import 'package:loono/ui/screens/find_doctor/find_doctor.dart';
import 'package:loono/ui/screens/prevention/prevention.dart';
import 'package:loono/utils/registry.dart';
import 'package:provider/provider.dart';

/// Post-auth main screen.
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  StreamSubscription? subscription;

  bool connectivityLocked = true;

  static final List<Widget> _pages = <Widget>[
    const PreventionScreen(),
    FindDoctorScreen(),
    const AboutHealthScreen(),
  ];

  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

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

    /// fetch examinations after network reconnection
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
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
      child: Scaffold(
        body: _pages.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: LoonoColors.primaryEnabled,
          onTap: _onItemTapped,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: context.l10n.main_menu_item_prevention,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.search),
              label: context.l10n.main_menu_item_find_doc,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.lightbulb_outline),
              label: context.l10n.main_menu_item_about_health,
            ),
          ],
        ),
      ),
    );
  }
}
