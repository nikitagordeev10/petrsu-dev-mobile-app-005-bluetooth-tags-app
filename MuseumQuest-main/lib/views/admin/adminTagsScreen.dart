// class adminTagsScreen extends StatefulWidget {
//   const adminTagsScreen ({Key? key}) : super(key: key);
//
//   @override
//   _adminTagsScreenState createState() => _adminTagsScreenState();
// }
//
// class _adminTagsScreenState extends State<adminTagsScreen> {
//   int _selectedIndex = 2;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Метки', style: TextStyle(color: Colors.white)),
//         centerTitle: true,
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           buildLabelCard(),
//           buildLabelCard(),
//           buildLabelCard(),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: Color(0xFF252836),
//         selectedItemColor: Color(0xFF1AACBC), // Цвет выделенной вкладки
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.museum_outlined),
//             label: 'Квесты',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.category),
//             label: 'Экспонаты',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.contactless),
//             label: 'Метки',
//           ),
//         ],
//       ),
//     );
//   }
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//       if (index == 0) { // Проверяем, что нажата вторая вкладка (индекс 1)
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => adminHomeScreen()), // Переходим на экран экспонатов
//         );
//       }
//       if (index == 1) { // Проверяем, что нажата вторая вкладка (индекс 1)
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => adminExibitScreen()), // Переходим на экран экспонатов
//         );
//       }
//       if (index == 2) { // Проверяем, что нажата вторая вкладка (индекс 1)
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => adminTagsScreen()), // Переходим на экран экспонатов
//         );
//       }
//     });
//   }
//
//
//
//
//   Widget buildLabelCard() {
//     return Card(
//       margin: const EdgeInsets.all(16),
//       color: const Color(0xFF252836),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           ListTile(
//             title: const Text(
//               'Метка Ruuvi',
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Text(
//                   'id: 8583841',
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 Text(
//                   'статус: свободна',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//             child: ElevatedButton(
//               onPressed: () {},
//               style: ElevatedButton.styleFrom(
//                 padding: EdgeInsets.symmetric(vertical: 10),
//                 backgroundColor: Colors.transparent, // Убираем заливку кнопки
//                 shape: RoundedRectangleBorder(
//                   side: BorderSide(color: const Color(0xFFEA5F5F), width: 1),
//                   borderRadius: BorderRadius.zero,
//                 ),
//               ),
//               child: Center(
//                 child: Text(
//                   'Удалить',
//                   style: TextStyle(color: const Color(0xFFEA5F5F)), // Цвет текста кнопки
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'adminQuestAdd1Screen.dart';
import 'adminNoteDeleteQuestScreen.dart';
import 'adminExibitScreen.dart';
import 'adminTagsScreen.dart';
import 'adminHomeScreen.dart';
import 'adminTagAddScreen.dart';
import 'adminExibitScreen.dart';

import 'package:museum_app/modules/tags.dart';

class adminTagsScreen extends StatefulWidget {
  const adminTagsScreen({Key? key}) : super(key: key);

  @override
  _adminTagsScreenState createState() => _adminTagsScreenState();
}

class _adminTagsScreenState extends State<adminTagsScreen> {
  int _selectedIndex = 0;
  List<Tag> _tags = [];

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
              itemCount: _tags.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildTagCard(_tags[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: ElevatedButton(
              onPressed: _navigateToAddTag,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 10),
                backgroundColor: Colors.transparent, // Убираем заливку кнопки
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: const Color(0xFF1AACBC), width: 1),
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
              child: Center(
                child: Text(
                  'Добавить экспонат',
                  style: TextStyle(color: const Color(0xFF1AACBC)), // Цвет текста кнопки
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

  Widget _buildTagCard(Tag tag) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: Color(0xFF252836),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tag.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                tag.id,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              Text(
                tag.status,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: MaterialButton(
                        onPressed: () {
                          _showDeleteDialog(tag);
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


  void _navigateToAddTag() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => adminTagAddScreen()),
    );

    if (result != null) {
      setState(() {
        _tags.add(result as Tag);
      });
    }
  }

  void _showDeleteDialog(Tag tag) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: adminDeleteTagScreen(
            onCancel: () {
              Navigator.of(context).pop();
            },
            onDelete: () {
              setState(() {
                _tags.remove(tag);
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

class adminDeleteTagScreen extends StatelessWidget {
  final VoidCallback? onCancel;
  final VoidCallback? onDelete;

  const adminDeleteTagScreen({Key? key, this.onCancel, this.onDelete}) : super(key: key);

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
