import 'package:flutter/material.dart';
import 'package:museum_app/views/theme/theme.dart';
import 'userHomeScreen.dart';
import 'userSupportScreen.dart';
import 'userQuestScreen.dart';
import 'userNoteNewQuestVersion.dart';
import 'userNoteQuestWasDeleted.dart';
import 'package:museum_app/views/ui_widgets/questWidget.dart';
import 'package:museum_app/modules/questsModule.dart';

class userHomeScreen extends StatefulWidget {
  const userHomeScreen({Key? key}) : super(key: key);

  @override
  State<userHomeScreen> createState() => _userHomeScreenState();
}

class _userHomeScreenState extends State<userHomeScreen> {
  int _selectedIndex = 0;
  List<List<String>> questInfoList = []; //getQuestsInformation();
  final List<Widget> _screens = [
    userHomeScreen(),
    userSupportScreen(), // Замененный элемент
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
          MaterialPageRoute(builder: (context) => userSupportScreen()),
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
      String buttonText;
      Widget destinationScreen;
      List<int> foundExhibitsList = [];

      if (status == '0')
      {
        buttonText = 'Начать';
        destinationScreen = userQuestScreen(foundExhibitsList: [], questId: id);
      }
      else if (status == '1')
      {
        buttonText = 'Продолжить';
        foundExhibitsList = await getFoundExhibits(id);
        destinationScreen = userQuestScreen(foundExhibitsList: foundExhibitsList, questId: id);
      }
      else {
        buttonText = 'Пройти ещё раз';
        destinationScreen = userQuestScreen(foundExhibitsList: [], questId: id);
      }

      questWidgetList.add(
          buildCardWithBackground(
            context,
            status,
            imagePath,
            title,
            description,
            buttonText,
            destinationScreen,
            onContinuePressed: () {
              startTimer();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => destinationScreen),
              );
            },
            onRestartPressed: () {
              setQuestTime(id, Future.value(0));
              if (status == '1')
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => userQuestScreen(foundExhibitsList: [], questId: id)),
                );
              }
            },
          ));
    }
    return questWidgetList;
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
                     return ListView.builder(itemCount: snapshot.data?.length ?? 0,
    itemBuilder: (BuildContext context, int index) {return snapshot.data![index];},
    );
    }
    },
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              label: 'Квесты',
              icon: Image.asset(
                'lib/views/img/icons/quests.png',
              ),
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'lib/views/img/icons/support.png',
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
}