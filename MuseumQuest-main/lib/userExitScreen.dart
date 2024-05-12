import 'package:flutter/material.dart';
import 'package:museum_app/modules/quests_module.dart';
import 'userHomeScreen.dart';

class userExitScreen extends StatelessWidget {
  final List foundExhibits;
  final int questId;
  const userExitScreen({Key? key, required this.foundExhibits, required this.questId});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min, // Ограничиваем размер по содержимому
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'lib/img/icons/exit.png',
              width: 130, // Указываем размер изображения
              height: 130,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Выход из квеста',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Вы можете выйти или продолжить прохождение квеста',
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0), // Закругление радиусом 4
                ),
                backgroundColor: Color(0xFF1AACBC), // Цвет заднего фона кнопки
                minimumSize: Size(double.infinity, 48), // Ширина кнопки на всю доступную ширину
              ),
              child: Text(
                'Остаться',
                style: TextStyle(color: Colors.white), // Установка цвета текста на белый
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedButton(
              onPressed: () async {
                await setQuestStatus(questId, '1');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => userHomeScreen(),
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0), // Закругление радиусом 4
                ),
                side: BorderSide(color: Colors.white), // Белая обводка
                minimumSize: Size(double.infinity, 48), // Ширина кнопки на всю доступную ширину
              ),
              child: Text(
                'Выйти',
                style: TextStyle(color: Colors.white), // Установка цвета текста на белый
              ),
            ),
          ),

        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}