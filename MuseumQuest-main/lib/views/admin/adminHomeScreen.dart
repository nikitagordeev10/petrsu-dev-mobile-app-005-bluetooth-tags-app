import 'dart:io';

import 'package:flutter/material.dart';
import 'adminTagsScreen.dart';
import 'adminAllTagsScreen.dart';
import 'adminQuestAdd1Screen.dart';
import 'adminExibitScreen.dart';
import 'package:museum_app/modules/quest.dart';

class adminHomeScreen extends StatefulWidget {
  const adminHomeScreen({Key? key}) : super(key: key);

  @override
  _adminHomeScreenState createState() => _adminHomeScreenState();
}

class _adminHomeScreenState extends State<adminHomeScreen> {
  int _selectedIndex = 0;
  List<Quest> _quests = [];

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
      body: Column(
        children: [

          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(20.0),
              itemCount: _quests.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildQuestCard(_quests[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: ElevatedButton(
              onPressed: _navigateToAddQuest,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 10),
                backgroundColor: Color(0xFF1AACBC),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
              child: Text(
                'Добавить квест',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        ],
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
      if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => adminExibitScreen()),
        );
      }
      // if (index == 2)
      // {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => adminAllTagsScreen()),
      //   );
      // }
    });
  }

  Widget _buildQuestCard(Quest quest) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          image: DecorationImage(
            image: FileImage(quest.image),
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
                quest.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                quest.description,
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
                          // Navigate to edit quest screen
                        },
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
                        onPressed: () {
                          _showDeleteDialog(quest);
                        },
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

  void _navigateToAddQuest() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => adminQuestAdd1Screen()),
    );

    if (result != null) {
      setState(() {
        _quests.add(result as Quest);
      });
    }
  }

  void _showDeleteDialog(Quest quest) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: adminDeleteQuestScreen(
            onCancel: () {
              Navigator.of(context).pop();
            },
            onDelete: () {
              setState(() {
                _quests.remove(quest);
              });
              Navigator.of(context).pop();
            },
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        );
      },
    );
  }
}

class adminDeleteQuestScreen extends StatelessWidget {
  final VoidCallback? onCancel;
  final VoidCallback? onDelete;

  const adminDeleteQuestScreen({Key? key, this.onCancel, this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'lib/views/img/icons/delete.png',
            width: 130,
            height: 130,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Удаление квеста',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Квест будет удалён без возможности восстановления',
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: onDelete,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              backgroundColor: Color(0xFF1AACBC),
              minimumSize: Size(double.infinity, 48),
            ),
            child: Text(
              'Удалить',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: OutlinedButton(
            onPressed: onCancel,
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              side: BorderSide(color: Colors.white),
              minimumSize: Size(double.infinity, 48),
            ),
            child: Text(
              'Отмена',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
