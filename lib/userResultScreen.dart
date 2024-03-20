import 'package:flutter/material.dart';
import 'userHomeScreen.dart';
import 'userQuestScreen.dart';
import 'userCheckBluetoothScreen.dart';
import 'userCheckQuestionScreen.dart';
import 'userExhibitScreen.dart';
import 'userExitScreen.dart';
import 'userResultScreen.dart';
class userResultScreen extends StatelessWidget {
  const userResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Результаты'),
            TextButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
              onPressed: () {
                //Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context)
                    {
                      return const userHomeScreen();
                    },
                  ),
                );
              },
              icon: const Icon(Icons.arrow_circle_right_sharp),
              label: const Text('На главную'),
            ),
          ],
        ),
      ),
      ),
    );
  }
}