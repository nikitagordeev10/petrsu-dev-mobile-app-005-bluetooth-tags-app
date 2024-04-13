import 'package:flutter/material.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1F1D2B),
        title: Text('Квесты'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          _buildCardWithBackground(
            context,
            'lib/img/background_image_1.jpg',
            'Одежда',
            'Традиционная одежда, вышивка, украшения и ткачество',
          ),
          SizedBox(height: 20),
          _buildCardWithBackground(
            context,
            'lib/img/background_image_2.jpg',
            'Изобретения',
            'Лодки, инструменты, украшения из меди и многое другое',
          ),
          SizedBox(height: 20),
          _buildCardWithBackground(
            context,
            'lib/img/background_image_3.jpg',
            'Национальные блюда',
            'Традиционные карельские блюда',
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ElevatedButton(
              onPressed: () {
                // Добавьте обработчик события для кнопки "Добавить квест"
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1AACBC), // Цвет кнопки
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0), // Закругление углов
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0), // Отступы кнопки
                child: Text(
                  'Добавить квест',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
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
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildCardWithBackground(BuildContext context, String imagePath, String title, String description) {
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
                        onPressed: () {},
                        color: Color(0xFF1AACBC),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Text('Редактировать', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: MaterialButton(
                        onPressed: () {},
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          side: BorderSide(color: Color(0xFFEA5F5F), width: 2),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Text('Удалить', style: TextStyle(color: Color(0xFFEA5F5F))),
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

