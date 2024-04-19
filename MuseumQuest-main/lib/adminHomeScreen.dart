import 'package:flutter/material.dart';
import 'adminExibitScreen.dart';
import 'adminTagsScreen.dart';
import 'adminQuestEditScreen.dart';
import 'adminQuestAddScreen.dart';

class adminHomeScreen extends StatefulWidget {
  const adminHomeScreen({Key? key}) : super(key: key);

  @override
  _adminHomeScreenState createState() => _adminHomeScreenState();
}

class _adminHomeScreenState extends State<adminHomeScreen> {
  int _selectedIndex = 0;
  List<String> _titles = [
    'Одежда',
    'Изобретения',
    'Национальные блюда',
  ];
  List<String> _descriptions = [
    'Традиционная одежда, вышивка, украшения и ткачество',
    'Лодки, инструменты, украшения из меди и многое другое',
    'Традиционные карельские блюда',
  ];
  List<String> _images = [
    'lib/img/background_image_1.jpg',
    'lib/img/background_image_2.jpg',
    'lib/img/background_image_3.jpg',
  ];

  void _removeCard(int index) {
    setState(() {
      _titles.removeAt(index);
      _descriptions.removeAt(index);
      _images.removeAt(index);
    });
  }

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
      body: ListView.builder(
        padding: EdgeInsets.all(20.0),
        itemCount: _titles.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildCardWithBackground(
            context,
            _images[index],
            _titles[index],
            _descriptions[index],
            index,
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF252836),
        selectedItemColor: Color(0xFF1AACBC),
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
      if (index == 0) {
        // Handle navigation to quests screen
      }
      if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => adminExibitScreen()),
        );
      }
      if (index == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => adminTagsScreen()),
        );
      }
    });
  }

  Widget _buildCardWithBackground(
      BuildContext context,
      String imagePath,
      String title,
      String description,
      int index,
      ) {
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
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => adminQuestEditScreen()),
                          );
                        },
                        color: Color(0xFF1AACBC),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Text('Редактировать',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: MaterialButton(
                        onPressed: () {
                          _removeCard(index);
                        },
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          side: BorderSide(
                              color: Color(0xFFEA5F5F), width: 2),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Text('Удалить',
                            style: TextStyle(color: Color(0xFFEA5F5F))),
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
