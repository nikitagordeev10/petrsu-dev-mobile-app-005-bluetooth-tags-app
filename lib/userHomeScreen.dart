import 'package:flutter/material.dart';
import 'userSettingsScreen.dart';
import 'userQuestScreen.dart';
import 'userCheckBluetoothScreen.dart';
import 'userCheckQuestionScreen.dart';
import 'userExhibitScreen.dart';
import 'userExitScreen.dart';
import 'userResultScreen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const userHomeScreen(),
        //'/settings': (context) => const userSettingsScreen(),
        '/quest': (context) => const userQuestScreen(),
        '/result': (context) => const userResultScreen(),
        '/exit': (context) => const userExitScreen(),
        '/exhibit': (context) => const userExhibitScreen(),
        '/question': (context) => const userCheckQuestionScreen(),
        '/tracker': (context) => const userCheckBluetoothScreen(),
      },
    ),
  );
}

class userHomeScreen extends StatelessWidget {
  const userHomeScreen({Key? key}): super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Главная страница'),
              TextButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/quest');
                },
                icon: const Icon(Icons.arrow_circle_right_sharp),
                label: const Text('Квест'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}