import 'package:flutter/material.dart';
import 'userExhibitScreen.dart';
import 'userExitScreen.dart';
import 'userResultScreen.dart';
class userQuestScreen extends StatelessWidget {
  const userQuestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Квест'),
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
                        return const userExitScreen();
                    },
                ),
              );
            },
              icon: const Icon(Icons.arrow_circle_right_sharp),
              label: const Text('Выход из квеста'),
            ),
            TextButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const userExhibitScreen();
                    },
                  ),
                );
              },
              icon: const Icon(Icons.arrow_circle_right_sharp),
              label: const Text('Экспонат'),
            ),
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
                      return const userResultScreen();
                    },
                  ),
                );
              },
              icon: const Icon(Icons.arrow_circle_right_sharp),
              label: const Text('Результаты'),
            ),
          ],
        ),
      ),
      ),
    );
  }
}