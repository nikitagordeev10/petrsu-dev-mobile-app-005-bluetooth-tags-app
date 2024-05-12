import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:museum_app/userHomeScreen.dart';
import 'userHomeScreen.dart';
import 'adminAuthorizationScreen.dart'; // Импорт экрана администраторской авторизации
import 'package:url_launcher/url_launcher.dart';


class userSupportScreen extends StatefulWidget {
  const userSupportScreen({Key? key}) : super(key: key);

  @override
  _userSupportScreenState createState() => _userSupportScreenState();
}

class _userSupportScreenState extends State<userSupportScreen> {
  int _tapCount = 0;
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    userHomeScreen(),
    userSupportScreen(), // Замененный элемент
  ];

  void _onTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Добавляем проверку индекса и перенаправляем пользователя на соответствующий экран
      if (_selectedIndex == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => userHomeScreen()),
        );
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1F1D2B),
        automaticallyImplyLeading: false, // Удалить иконку назад
        centerTitle: true, // Выровнять заголовок по центру
        title: Text('Поддержка'),
      ),

      backgroundColor: const Color(0xFF1F1D2B), // Фоновый цвет
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _incrementTapCount,
                child: Image.asset(
                  'lib/img/support_image.png',
                  width: 200,
                  height: 200,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Если у вас возникли проблемы, напишите нам по адресу muzbingo@yandex.ru для получения помощи',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
              SizedBox( // чтобы кнопка была на всю ширину
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () async {
                final toEmail = 'muzbingo@yandex.ru';
                final subject = 'Вопрос о приложении МузБинго';
                final message = 'Здравствуйте,\n\nУ меня возникли некоторые вопросы по использованию вашего приложения МузБинго. Я столкнулся с некоторыми проблемами и хотел бы получить помощь.';
                final url = 'mailto:$toEmail?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(message)}';

                if (await canLaunch(url)) {
                await launch(url);
                } else {
                print('Не удалось открыть приложение электронной почты.');
                }
                },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1AACBC), // цвет кнопки
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4), // закругление углов
                    ),
                  ),
                  child: const Text('Написать на почту', style: TextStyle(color: Colors.white)),
                ),

              ),
            ],
          ),
        ),

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
    );
  }



  void _incrementTapCount() {
    setState(() {
      _tapCount++;
      if (_tapCount == 5) {
        // Проверяем, достигло ли количество нажатий 5
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => adminAuthorizationScreen()), // Переход на экран администраторской авторизации
        );
        _tapCount = 0; // Сбрасываем счетчик после перехода
      }
    });
  }
}
