import 'package:flutter/material.dart';
import 'package:museum_app/theme/theme.dart';
import 'package:museum_app/views/user/userHomeScreen.dart';
import 'package:museum_app/views/user/userSupportScreen.dart';
import 'package:museum_app/views/admin/adminHomeScreen.dart';
import 'package:museum_app/views/admin/adminExibitScreen.dart';
import 'package:museum_app/views/admin/adminTagsScreen.dart';

class userMainScreen extends StatefulWidget {
  const userMainScreen({super.key});

  @override
  State<userMainScreen> createState() => _userMainScreenState();
}

class _userMainScreenState extends State<userMainScreen> {
  int _selectedIndex = 0;

  // 0 - пользователь, 1 - админ
  int userStatus = 0;

  final List<Widget> _screens = [];

  getScreens() {
    if (userStatus == 0)
      return [
        userHomeScreen(),
        userSupportScreen()
      ];
    else if (userStatus == 1)
      return [
        adminHomeScreen(),
        adminExibitScreen(),
        adminTagsScreen()
      ];
  }

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
              label: 'Поддержка',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onTapped,
        ),
      ),
    );
  }
}
