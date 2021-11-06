import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/routers/app_router.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    Text(
      'Screen: Já',
      style: LoonoFonts.headerFontStyle,
    ),
    Text(
      'Screen: Najít lékaře',
      style: LoonoFonts.headerFontStyle,
    ),
    Text(
      'Screen: Objev zdraví',
      style: LoonoFonts.headerFontStyle,
    ),
  ];

  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              // TODO: Only user with created account can open Settings
              Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  onPressed: () {
                    AutoRouter.of(context).push(const SettingsRouter());
                  },
                  child: const Text('SETTINGS'),
                ),
              ),
              Center(
                child: _pages.elementAt(_selectedIndex),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: LoonoColors.primaryEnabled,
          onTap: _onItemTapped,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: context.l10n.main_menu_item_me,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.search),
              label: context.l10n.main_menu_item_find_doc,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.lightbulb_outline),
              label: context.l10n.main_menu_item_explore,
            ),
          ],
        ),
      ),
    );
  }
}
