import 'package:flutter/material.dart';
import 'adminHomeScreen.dart';
import 'userExitScreen.dart';
import 'userResultScreen.dart';
import 'userCheckBluetoothScreen.dart'; // Шаг 1: Импорт файла
import 'userCheckQuestionScreen.dart'; // Шаг 1: Импорт файла
import 'adminTagsScreen.dart';
import 'adminExibitAddScreen.dart';

class adminExibitScreen extends StatefulWidget {
  const adminExibitScreen({Key? key});

  @override
  _adminExibitScreenState createState() => _adminExibitScreenState();
}

class _adminExibitScreenState extends State<adminExibitScreen> {
  List<bool> _isCardCorrect = List.generate(6, (index) => false);
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = (screenWidth - 40) / 2; // Делим ширину экрана пополам и вычитаем отступы между карточками
    double cardHeight = cardWidth + 45; // Высота карточки равна ширине изображения плюс высота кнопки

    return WillPopScope(
      onWillPop: () async {
        await showDialog(
          context: context,
          builder: (context) => userExitScreen(),
        );
        return false; // Returning false prevents the back operation
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF1F1D2B),
          automaticallyImplyLeading: false, // Удалить иконку назад
          centerTitle: true, // Выровнять заголовок по центру
          title: Text('Экспонаты'),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Wrap(
                      alignment: WrapAlignment.spaceEvenly,
                      children: List.generate(
                        6,
                            (index) => _buildExhibitCard(
                          context,
                          index + 1, // Добавляем 1, чтобы начать с quest_1.jpg
                          index, // Передаём индекс вопроса
                          cardWidth,
                          cardHeight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xFF252836),
          selectedItemColor: Color(0xFF1AACBC), // Цвет выделенной вкладки
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.article_outlined),
              label: 'Квесты',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.museum_outlined),
              label: 'Экспонаты',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pin_drop_outlined),
              label: 'Метки',
            ),
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) { // Проверяем, что нажата вторая вкладка (индекс 1)
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => adminHomeScreen()), // Переходим на экран экспонатов
        );
      }
      if (index == 1) { // Проверяем, что нажата вторая вкладка (индекс 1)
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => adminExibitScreen()), // Переходим на экран экспонатов
        );
      }
      if (index == 2) { // Проверяем, что нажата вторая вкладка (индекс 1)
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => adminTagsScreen()), // Переходим на экран экспонатов
        );
      }
    });
  }

  Widget _buildExhibitCard(
      BuildContext context,
      int questNumber,
      int questionIndex, // Индекс вопроса
      double cardWidth,
      double cardHeight,
      ) {
    final String imagePath = 'lib/img/quest/quest_$questNumber.png';
    final String magnifyingGlassIcon = 'lib/img/icons/magnifying_glass.png'; // Иконка лупы
    final String deleteIcon = 'lib/img/icons/delete_small.png'; // Иконка удаления
    final String editIcon = 'lib/img/icons/edit.png'; // Иконка редактирования

    return Container(
      width: cardWidth,
      height: cardHeight,
      margin: EdgeInsets.all(8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 4,
        color: _isCardCorrect[questionIndex] ? Colors.green : null,
        child: Stack(
          alignment: Alignment.topRight, // Выравниваем иконки в правом верхнем углу
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: Image.asset(
                          imagePath,
                          fit: BoxFit.contain,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0)
                        .add(EdgeInsets.only(top: 8.0))
                        .add(EdgeInsets.only(bottom: 1.0)),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                if (_isCardCorrect[questionIndex])
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Найдено',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                if (!_isCardCorrect[questionIndex])
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF1AACBC),
                            // onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                              // side: BorderSide(color: Colors.white),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                                MaterialPageRoute(
                                  builder: (context) => adminExibitAddScreen(),
                                ),
                            );
                          },
                          child: Image.asset(
                            editIcon,
                            width: 25,
                            height: 20,
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFC0392E),
                            // onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                              // side: BorderSide(color: Colors.white),
                            ),
                          ),
                          onPressed: () {
                            // Действия при нажатии на кнопку редактирования
                          },
                          child: Image.asset(
                            deleteIcon,
                            width: 25,
                            height: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  // Действия при нажатии на иконку
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Image.asset(
                        imagePath,
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                },
                child: Image.asset(
                  magnifyingGlassIcon, // Путь к изображению иконки лупы
                  width: 30, // Ширина иконки
                  height: 30, // Высота иконки
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



  void _checkAllAnswers() {
    if (_isCardCorrect.every((isCorrect) => isCorrect)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => userResultScreen(),
        ),
      );
    }
  }
}



