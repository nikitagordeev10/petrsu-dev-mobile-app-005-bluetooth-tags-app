import 'package:flutter/material.dart';
import 'package:museum_app/theme/theme.dart';
import 'package:museum_app/userHomeScreen.dart';
import 'package:museum_app/userSettingsScreen.dart';

class userMainScreen extends StatefulWidget {
  const userMainScreen({super.key});

  @override
  State<userMainScreen> createState() => _userMainScreenState();
}

class _userMainScreenState extends State<userMainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    userHomeScreen(),
    userSettingsScreen(),
  ];

  void _onTapped(int index) {
    setState(() {
        _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      home: Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              label: 'Квесты',
              icon: Icon(Icons.museum_rounded),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Настройки',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onTapped,
        ),
      ),
    );
  }
}
