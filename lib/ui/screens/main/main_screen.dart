import 'package:flutter/material.dart';
import 'package:loono/constants.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    Text(
      'Page: Já',
      style: LoonoFonts.headerFontStyle,
    ),
    Text(
      'Page: Najít lékaře',
      style: LoonoFonts.headerFontStyle,
    ),
    Text(
      'Page: Objev zdraví',
      style: LoonoFonts.headerFontStyle,
    ),
  ];

  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
