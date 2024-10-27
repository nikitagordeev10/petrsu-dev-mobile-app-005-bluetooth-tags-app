import 'dart:io';

import 'package:flutter/material.dart';
import 'package:museum_app/views/admin/adminQuestEdit1Screen.dart';
import 'package:museum_app/views/theme/theme.dart';
// import 'adminHomeScreen.dart';
import 'adminExibitScreen.dart';
import 'adminQuestAdd1Screen.dart';
import 'adminTagsScreen.dart';
// import 'userNoteNewQuestVersion.dart';
// import 'userNoteQuestWasDeleted.dart';
import 'package:museum_app/views/ui_widgets/adminQuestWidget.dart';
import 'package:museum_app/modules/questsModule.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class adminHomeScreen extends StatefulWidget {
  const adminHomeScreen({Key? key}) : super(key: key);

  @override
  State<adminHomeScreen> createState() => _adminHomeScreenState();
}

class _adminHomeScreenState extends State<adminHomeScreen> {
  int _selectedIndex = 0;
  List<List<String>> questInfoList = []; //getQuestsInformation();
  final List<Widget> _screens = [
    adminHomeScreen(),
    adminExibitScreen(), // Замененный элемент
  ];

  @override
  void initState() {
    super.initState();
    _loadQuestInfo();
  }

  void _loadQuestInfo() async {
    var quests = await getQuestsInformation();
    setState(() {
      questInfoList = quests;
    });
  }
  void _onTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Добавляем проверку индекса и перенаправляем пользователя на соответствующий экран
      if (_selectedIndex == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => adminExibitScreen()),
        );
      }
    });
  }

  // получаем список виджетов для квестов
  Future<List<Widget>> getQuestWidgetList() async
  {
    List<Widget> questWidgetList = [];
    List<List<String>> questInfoList = await getQuestsInformation();

    for (final element in questInfoList)
    {
      int id = int.parse(element[0]);
      String title = element[1];
      String description = element[2];
      String imagePath = element[3];
      String status = await getQuestStatus(id);
      Widget destinationScreen;
      List<int> foundExhibitsList = [];


      destinationScreen = adminQuestAdd1Screen();

      questWidgetList.add(
        buildCardWithBackground(
          context,
          status,
          imagePath,
          title,
          description,
          destinationScreen,
          onContinuePressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => destinationScreen),
            );
          },
          onEditPressed: () {
            // Действие при нажатии на кнопку Редактировать
            // Например, переход на экран редактирования квеста
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => adminQuestEditScreen()),
            );
          },
          onDeletePressed: () {
            // Действие при нажатии на кнопку Удалить
            // Например, удаление квеста
            deleteQuest(id);
          },
        ),
      );
    }
    return questWidgetList;
  }



// Функция для удаления квеста из JSON файла
  void deleteQuest(int id) async {
    try {
      // Чтение содержимого файла
      String jsonString = await rootBundle.loadString('lib/database/exhibit.json');
      List<dynamic> quests = json.decode(jsonString);

      // Удаление квеста с заданным id
      quests.removeWhere((quest) => quest['id'] == id);

      // Запись обновленного списка квестов в файл
      await File('lib/database/exhibit.json').writeAsString(json.encode(quests));

      // Обновление списка квестов на экране
      _loadQuestInfo();
    } catch (e) {
      print('Ошибка при удалении квеста: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    //List<Widget> widgetList = [];
    //widgetList = getQuestWidgetList();
    return MaterialApp(
      theme: themeData,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF1F1D2B),
          automaticallyImplyLeading: false, // Удалить иконку назад
          centerTitle: true, // Выровнять заголовок по центру
          title: Text('Квесты'),
        ),
        //body: ListView.builder(
        body: FutureBuilder(
          future: getQuestWidgetList(),
          builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Индикатор загрузки
            } else if (snapshot.hasError) {
              return Text('Ошибка: ${snapshot.error}'); // Отображение ошибки
            } else {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return snapshot.data![index];
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
              );
            }
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
      ),
    );
  }


  void _navigateToAddQuest() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => adminQuestAdd1Screen()),
    );

    // if (result != null) {
    //   setState(() {
    //     _quests.add(result as Quest);
    //   });
    // }
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
      if (index == 2)
      {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => adminTagsScreen()),
        );
      }
    });
  }

}










// ----------------------------------------------------------------------

// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'adminTagsScreen.dart';
// import 'adminAllTagsScreen.dart';
// import 'adminQuestAdd1Screen.dart';
// import 'adminExibitScreen.dart';
// import 'package:museum_app/modules/quest.dart';
//
// class adminHomeScreen extends StatefulWidget {
//   const adminHomeScreen({Key? key}) : super(key: key);
//
//   @override
//   _adminHomeScreenState createState() => _adminHomeScreenState();
// }
//
// class _adminHomeScreenState extends State<adminHomeScreen> {
//   int _selectedIndex = 0;
//   List<Quest> _quests = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xFF1F1D2B),
//         title: Text('Квесты'),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Column(
//         children: [
//
//           Expanded(
//             child: ListView.builder(
//               padding: EdgeInsets.all(20.0),
//               itemCount: _quests.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return _buildQuestCard(_quests[index]);
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
//             child: ElevatedButton(
//               onPressed: _navigateToAddQuest,
//               style: ElevatedButton.styleFrom(
//                 padding: EdgeInsets.symmetric(vertical: 10),
//                 backgroundColor: Color(0xFF1AACBC),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(4.0),
//                 ),
//               ),
//               child: Text(
//                 'Добавить квест',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 16.0,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: Color(0xFF252836),
//         selectedItemColor: Color(0xFF1AACBC),
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
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//       if (index == 1) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => adminExibitScreen()),
//         );
//       }
//       // if (index == 2)
//       // {
//       //   Navigator.push(
//       //     context,
//       //     MaterialPageRoute(builder: (context) => adminAllTagsScreen()),
//       //   );
//       // }
//     });
//   }
//
//   Widget _buildQuestCard(Quest quest) {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(4.0),
//       ),
//       elevation: 4,
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(4.0),
//           image: DecorationImage(
//             image: FileImage(quest.image),
//             fit: BoxFit.cover,
//             colorFilter: ColorFilter.mode(
//               Color(0xFF252836).withOpacity(0.8),
//               BlendMode.darken,
//             ),
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 quest.name,
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//               SizedBox(height: 10),
//               Text(
//                 quest.description,
//                 style: TextStyle(fontSize: 16, color: Colors.white),
//               ),
//               SizedBox(height: 10),
//               Row(
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(right: 10.0),
//                       child: MaterialButton(
//                         onPressed: () {
//                           // Navigate to edit quest screen
//                         },
//                         color: Color(0xFF1AACBC),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(4.0),
//                         ),
//                         clipBehavior: Clip.antiAlias,
//                         child: Text('Редактировать', style: TextStyle(color: Colors.white)),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 10.0),
//                       child: MaterialButton(
//                         onPressed: () {
//                           _showDeleteDialog(quest);
//                         },
//                         color: Colors.transparent,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(4.0),
//                           side: BorderSide(color: Color(0xFFEA5F5F), width: 2),
//                         ),
//                         clipBehavior: Clip.antiAlias,
//                         child: Text('Удалить', style: TextStyle(color: Color(0xFFEA5F5F))),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // void _navigateToAddQuest() async {
//   //   final result = await Navigator.push(
//   //     context,
//   //     MaterialPageRoute(builder: (context) => adminQuestAdd1Screen()),
//   //   );
//   //
//   //   if (result != null) {
//   //     setState(() {
//   //       _quests.add(result as Quest);
//   //     });
//   //   }
//   // }
//
//   // void _showDeleteDialog(Quest quest) {
//   //   showDialog(
//   //     context: context,
//   //     builder: (BuildContext context) {
//   //       return AlertDialog(
//   //         content: adminDeleteQuestScreen(
//   //           onCancel: () {
//   //             Navigator.of(context).pop();
//   //           },
//   //           onDelete: () {
//   //             setState(() {
//   //               _quests.remove(quest);
//   //             });
//   //             Navigator.of(context).pop();
//   //           },
//   //         ),
//   //         shape: RoundedRectangleBorder(
//   //           borderRadius: BorderRadius.circular(10.0),
//   //         ),
//   //       );
//   //     },
//   //   );
//   // }
// }
//
// // class adminDeleteQuestScreen extends StatelessWidget {
// //   final VoidCallback? onCancel;
// //   final VoidCallback? onDelete;
// //
// //   const adminDeleteQuestScreen({Key? key, this.onCancel, this.onDelete}) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       mainAxisSize: MainAxisSize.min,
// //       children: [
// //         Padding(
// //           padding: const EdgeInsets.all(8.0),
// //           child: Image.asset(
// //             'lib/views/img/icons/delete.png',
// //             width: 130,
// //             height: 130,
// //           ),
// //         ),
// //         Padding(
// //           padding: const EdgeInsets.all(8.0),
// //           child: Text(
// //             'Удаление квеста',
// //             style: TextStyle(
// //               fontWeight: FontWeight.bold,
// //               fontSize: 18,
// //             ),
// //           ),
// //         ),
// //         Padding(
// //           padding: const EdgeInsets.all(8.0),
// //           child: Text(
// //             'Квест будет удалён без возможности восстановления',
// //             textAlign: TextAlign.center,
// //           ),
// //         ),
// //         Padding(
// //           padding: const EdgeInsets.all(8.0),
// //           child: ElevatedButton(
// //             onPressed: onDelete,
// //             style: ElevatedButton.styleFrom(
// //               shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.circular(4.0),
// //               ),
// //               backgroundColor: Color(0xFF1AACBC),
// //               minimumSize: Size(double.infinity, 48),
// //             ),
// //             child: Text(
// //               'Удалить',
// //               style: TextStyle(color: Colors.white),
// //             ),
// //           ),
// //         ),
// //         Padding(
// //           padding: const EdgeInsets.all(8.0),
// //           child: OutlinedButton(
// //             onPressed: onCancel,
// //             style: OutlinedButton.styleFrom(
// //               shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.circular(4.0),
// //               ),
// //               side: BorderSide(color: Colors.white),
// //               minimumSize: Size(double.infinity, 48),
// //             ),
// //             child: Text(
// //               'Отмена',
// //               style: TextStyle(color: Colors.white),
// //             ),
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }
