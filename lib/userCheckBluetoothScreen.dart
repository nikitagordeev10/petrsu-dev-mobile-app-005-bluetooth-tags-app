import 'package:flutter/material.dart';
import 'userQuestScreen.dart';
class userCheckBluetoothScreen extends StatelessWidget {
  const userCheckBluetoothScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Проверка (нахождение маячка)'),
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
                      return const userQuestScreen();
                    },
                  ),
                );
              },
              icon: const Icon(Icons.arrow_circle_right_sharp),
              label: const Text('Вернуться к квесту'),
            ),
          ],
        ),
      ),
      ),
    );
  }
}