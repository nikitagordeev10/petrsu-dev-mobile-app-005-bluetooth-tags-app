import 'package:flutter/material.dart';
import 'userHomeScreen.dart';

class userQuestWasDeleted extends StatelessWidget {
  const userQuestWasDeleted({Key? key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min, // Ограничиваем размер по содержимому
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'lib/img/icons/delete.png',
              width: 130, // Указываем размер изображения
              height: 130,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Квест был удалён',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Квест больше не доступен для прохождения',
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
                'Окей',
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
