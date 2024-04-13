import 'package:flutter/material.dart';
import 'package:museum_app/theme/theme.dart';
import 'package:museum_app/userHomeScreen.dart';
import 'package:museum_app/userSupportScreen.dart';
import 'package:museum_app/userQuestScreen.dart';
import 'package:museum_app/userNewQuestVersion.dart';
import 'package:museum_app/userQuestWasDeleted.dart';

class userHomeScreen extends StatefulWidget {
  const userHomeScreen({Key? key}) : super(key: key);

  @override
  State<userHomeScreen> createState() => _userHomeScreenState();
}

class _userHomeScreenState extends State<userHomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    userHomeScreen(),
    userSupportScreen(), // Замененный элемент
  ];

  void _onTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Добавляем проверку индекса и перенаправляем пользователя на соответствующий экран
      if (_selectedIndex == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => userSupportScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF1F1D2B),
          automaticallyImplyLeading: false, // Удалить иконку назад
          centerTitle: true, // Выровнять заголовок по центру
          title: Text('Квесты'),
        ),
        body: ListView(
          padding: EdgeInsets.all(20.0),
          children: [
            _buildCardWithBackground(
              context,
              'lib/img/background_image_1.jpg',
              'Одежда',
              'Традиционная одежда, вышивка, украшения и ткачество',
              'Начать',
              userQuestScreen(),
              onContinuePressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => userQuestScreen()),
                );
              },
            ),
            SizedBox(height: 20),
            _buildCardWithBackground(
              context,
              'lib/img/background_image_2.jpg',
              'Изобретения',
              'Лодки, инструменты, украшения из меди и многое другое',
              'Продолжить',
              userQuestScreen(),
              onContinuePressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => userNewQuestVersion()),
                );
              },
              onRestartPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => userNewQuestVersion()),
                );
              },
            ),
            SizedBox(height: 20),
            _buildCardWithBackground(
              context,
              'lib/img/background_image_3.jpg',
              'Национальные блюда',
              'Традиционная одежда, вышивка, украшения и ткачество',
              'Пройти ещё раз',
              userQuestWasDeleted(),
              onContinuePressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => userQuestWasDeleted()),
                );
              },
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              label: 'Квесты',
              icon: Image.asset(
                'lib/img/icons/quests.png',
              ),
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'lib/img/icons/support.png',
              ),
              label: 'Поддержка',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onTapped,
        ),
      ),
    );
  }

  Widget _buildCardWithBackground(BuildContext context, String imagePath, String title, String description, String buttonText, Widget destinationScreen, {Function()? onContinuePressed, Function()? onRestartPressed}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Color(0xFF252836).withOpacity(0.8),
              BlendMode.darken,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                description,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: MaterialButton(
                        onPressed: onContinuePressed ?? () {},
                        color: Color(0xFF1AACBC),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Text(buttonText, style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                  if (onRestartPressed != null)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: MaterialButton(
                          onPressed: onRestartPressed,
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            side: BorderSide(color: Colors.white, width: 2),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Text('Начать сначала', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
