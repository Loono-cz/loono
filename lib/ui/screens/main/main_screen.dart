import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/auth/auth_service.dart';
import 'package:loono/utils/registry.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _authService = registry.get<AuthService>();

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
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Odhlásit se',
            onPressed: () async {
              await _authService.signOut();
              AutoRouter.of(context).replaceAll([const MainWrapperRoute()]);
            },
          ),
        ],
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: LoonoColors.primaryEnabled,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Já',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Najít lékaře',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb_outline),
            label: 'Objev zdraví',
          ),
        ],
      ),
    );
  }
}
