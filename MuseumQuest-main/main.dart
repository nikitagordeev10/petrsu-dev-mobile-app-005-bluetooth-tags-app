import 'package:flutter/material.dart';
import 'package:museum_app/userHomeScreen.dart';
import 'package:museum_app/theme/theme.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      home: const userHomeScreen(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      /*routes: {
        // '/': (context) => const userHomeScreen(),
        //'/settings': (context) => const userSettingsScreen(),
        '/quest': (context) => const userQuestScreen(),
        '/result': (context) => const userResultScreen(),
        '/exit': (context) => const userExitScreen(),
        '/exhibit': (context) => const userExhibitScreen(),
        '/question': (context) => const userCheckQuestionScreen(),
        '/tracker': (context) => const userCheckBluetoothScreen(),
      },*/
    );
  }
}



