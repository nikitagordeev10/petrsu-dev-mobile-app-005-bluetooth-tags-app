import 'package:flutter/material.dart';
import '../user/userCheckQuestionScreen.dart';

/*
Widget buildExhibitCard(
    BuildContext context,
    int questNumber,
    int questionIndex, // Индекс вопроса
    double cardWidth,
    double cardHeight,
    ) {
  final String imagePath = 'lib/views/img/quest/quest_$questNumber.png';
  final String magnifyingGlassIcon = 'lib/views/img/icons/magnifying_glass.png'; // Иконка лупы
  return Container(
    width: cardWidth,
    height: cardHeight,
    margin: EdgeInsets.all(8),
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 4,
      color: _isCardCorrect[questionIndex] ? Colors.green : null,
      child: Stack(
        alignment: Alignment.topRight, // Выравниваем иконку в правом верхнем углу
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Image.asset(
                        imagePath,
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0)
                      .add(EdgeInsets.only(top: 8.0))
                      .add(EdgeInsets.only(bottom: 1.0)),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              if (_isCardCorrect[questionIndex])
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Найдено',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              if (!_isCardCorrect[questionIndex])
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      // onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                        side: BorderSide(color: Colors.white),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => userCheckQuestionScreen(
                            questionIndex: questionIndex,
                            onAnswerSubmitted: (isCorrect) {
                              setState(() {
                                _isCardCorrect[questionIndex] = isCorrect;
                                _checkAllAnswers();
                              });
                            },
                          ),
                        ),
                      );
                    },
                    child: Text('Я нашел!', style: TextStyle(color: Colors.white)),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                // Действия при нажатии на иконку
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Image.asset(
                      imagePath,
                      fit: BoxFit.contain,
                    ),
                  ),
                );
              },
              child: Image.asset(
                magnifyingGlassIcon, // Путь к изображению иконки лупы
                width: 30, // Ширина иконки
                height: 30, // Высота иконки
              ),
            ),
          ),
        ],
      ),
    ),
  );
}*/
