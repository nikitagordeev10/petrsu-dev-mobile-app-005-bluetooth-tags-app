import 'package:flutter/material.dart';
import 'package:museum_app/theme/theme.dart';
import 'userQuestScreen.dart';
import 'userCheckBluetoothScreen.dart';
import 'userCheckQuestionScreen.dart';
import 'userExhibitScreen.dart';
import 'userExitScreen.dart';
import 'userResultScreen.dart';
import 'package:museum_app/models/quests_module.dart';
import 'package:museum_app/userSettingsScreen.dart';

class userHomeScreen extends StatefulWidget {
  const userHomeScreen({super.key});

  @override
  _userHomeScreenState createState() => _userHomeScreenState();
}

class _userHomeScreenState extends State<userHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Квесты"),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constrains) {
          return FutureBuilder<List<Widget>>(
              future: getQuests(),
              builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } 
                  else if (snapshot.hasData) {
                    List<Widget> questsListWidgets = snapshot.data!;
                    return ListView.builder(
                      itemCount: questsListWidgets.length,
                      itemBuilder: (BuildContext context, int index) {
                        return questsListWidgets[index];
                      },
                    );
                  }
                  else if (snapshot.hasError) {
                    return Center(
                      child: Text('Ошибка при загрузке данных'),
                    );
                  }
                  else {
                    return Container();
                }
              },
          );
        },
      ),
    );
  }
}