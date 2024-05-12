import 'package:flutter/material.dart';
import 'adminExibitScreen.dart';
import 'adminHomeScreen.dart';

class adminTagsScreen extends StatefulWidget {
  const adminTagsScreen ({Key? key}) : super(key: key);
  
  @override
  _adminTagsScreenState createState() => _adminTagsScreenState();
}

class _adminTagsScreenState extends State<adminTagsScreen> {
  int _selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Метки', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildLabelCard(),
          buildLabelCard(),
          buildLabelCard(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF252836),
        selectedItemColor: Color(0xFF1AACBC), // Цвет выделенной вкладки
        currentIndex: _selectedIndex,
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
  
  Widget buildLabelCard() {
    return Card(
      margin: const EdgeInsets.all(16),
      color: const Color(0xFF252836),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            title: const Text(
              'Метка Ruuvi',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'id: 8583841',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  'статус: свободна',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 10),
                backgroundColor: Colors.transparent, // Убираем заливку кнопки
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: const Color(0xFFEA5F5F), width: 1),
                  borderRadius: BorderRadius.zero,
                ),
              ),
              child: Center(
                child: Text(
                  'Удалить',
                  style: TextStyle(color: const Color(0xFFEA5F5F)), // Цвет текста кнопки
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}