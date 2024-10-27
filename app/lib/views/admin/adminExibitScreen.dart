import 'package:flutter/material.dart';
import 'adminHomeScreen.dart';
import 'package:museum_app/views/user/userNoteExitScreen.dart';
import 'package:museum_app/views/user/userResultScreen.dart';
import 'package:museum_app/views/user/userCheckBluetoothScreen.dart'; // Шаг 1: Импорт файла
import 'package:museum_app/views/user/userCheckQuestionScreen.dart'; // Шаг 1: Импорт файла
import 'adminTagsScreen.dart';
import 'adminExibitAdd1Screen.dart';
import 'package:museum_app/modules/exhibitModule.dart';

class adminExibitScreen extends StatefulWidget {
  const adminExibitScreen({Key? key});

  @override
  _adminExibitScreenState createState() => _adminExibitScreenState();
}

class _adminExibitScreenState extends State<adminExibitScreen> {
  List<List<String>> exhibitsList = [];

  @override
  void initState() {
    super.initState();
    _loadExhibits();
  }

  void _loadExhibits() async {
    exhibitsList = await getExhibitsInfo();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = (screenWidth - 40) / 2; // Делим ширину экрана пополам и вычитаем отступы между карточками
    double cardHeight = cardWidth + 45; // Высота карточки равна ширине изображения плюс высота кнопки

    return WillPopScope(
      onWillPop: () async {
        await showDialog(
          context: context,
          // TODO Заполнить информацию для передачи на другой экран
          builder: (context) => userExitScreen(foundExhibits: [], questId: 1,),
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
                        exhibitsList.length,
                            (index) => _buildExhibitCard(
                          context,
                          exhibitsList[index],
                          index, // Передаём индекс вопроса
                          cardWidth,
                          cardHeight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: ElevatedButton(
                  onPressed: _navigateToAddExibit,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    backgroundColor: Color(0xFF1AACBC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  child: Text(
                    'Добавить экспонат',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xFF252836),
          selectedItemColor: Color(0xFF1AACBC), // Цвет выделенной вкладки
          currentIndex: 1,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.museum_outlined),
              label: 'Квесты',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Экспонаты',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.contactless),
              label: 'Метки',
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToAddExibit() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => adminExibitAdd1Screen()),
    );

    // if (result != null) {
    //   setState(() {
    //     _quests.add(result as Quest);
    //   });
    // }
  }

  void _onItemTapped(int index) {
    setState(() {
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
      List<String> exhibit,
      int index, // Индекс вопроса
      double cardWidth,
      double cardHeight,
      ) {
    final String imagePath = exhibit[3]; // Change this to the index of image path in your exhibit data
    final String magnifyingGlassIcon = 'lib/views/img/icons/magnifying_glass.png'; // Иконка лупы
    final String deleteIcon = 'lib/views/img/icons/delete_small.png'; // Иконка удаления
    final String editIcon = 'lib/views/img/icons/edit.png'; // Иконка редактирования

    return Container(
      width: cardWidth,
      height: cardHeight,
      margin: EdgeInsets.all(8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 4,
        color: false ? Colors.green : null,
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
                if (false)
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
                if (!false)
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
                                builder: (context) => adminExibitAdd1Screen(),
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
}
