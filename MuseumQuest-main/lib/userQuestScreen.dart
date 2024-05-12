import 'package:flutter/material.dart';
import 'package:museum_app/modules/quests_module.dart';
import 'modules/exhibit_module.dart';
import 'userExitScreen.dart';
import 'userResultScreen.dart';
import 'userCheckBluetoothScreen.dart';
import 'userCheckQuestionScreen.dart';

class userQuestScreen extends StatefulWidget {
  final List<int> foundExhibitsList;
  final int questId;
  const userQuestScreen({Key? key, required this.foundExhibitsList, required this.questId});

  @override
  _userQuestScreenState createState() => _userQuestScreenState(foundExhibitsList: foundExhibitsList, questId: questId);
}

class _userQuestScreenState extends State<userQuestScreen> {
  List<int> foundExhibitsList;
  int questId;
  List<bool> _isCardCorrect = [];
  _userQuestScreenState({required this.foundExhibitsList, required this.questId});

void _loadCorrectCards() async {
  var cards = await getCorrectCardList(foundExhibitsList);
  setState(() {
    _isCardCorrect = cards;
  });
}
  @override
  void initState() {
    super.initState();
    // Инициализация _isCardCorrect здесь, если это возможно, или внутри Future.delayed
    _loadCorrectCards();
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = (screenWidth - 40) / 2;
    double cardHeight = cardWidth + 45;

    return WillPopScope(
      onWillPop: () async {
        await showDialog(
          context: context,
          builder: (context) => userExitScreen(foundExhibits: foundExhibitsList, questId: questId),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Изобретения'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: FutureBuilder<List<bool>>(
            future: getCorrectCardList(foundExhibitsList), // Здесь указываем Future, который нужно дождаться
            builder: (BuildContext context, AsyncSnapshot<List<bool>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Пока ждём данные, показываем индикатор загрузки
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // Если произошла ошибка, показываем текст ошибки
                return Center(child: Text('Ошибка: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                // Когда данные получены, строим интерфейс
                _isCardCorrect = snapshot.data!;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Wrap(
                            alignment: WrapAlignment.spaceEvenly,
                            children: List.generate(
                              6,
                                  (index) => buildExhibitCard(
                                context,
                                index + 1,
                                index,
                                cardWidth,
                                cardHeight,
 // Используем данные из snapshot
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                // Если данных нет, показываем сообщение об этом
                return Center(child: Text('Нет данных'));
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildExhibitCard(
      BuildContext context,
      int questNumber,
      int questionIndex, // Индекс вопроса
      double cardWidth,
      double cardHeight,
      ) {
    final String imagePath = 'lib/img/quest/quest_$questNumber.png';
    final String magnifyingGlassIcon = 'lib/img/icons/magnifying_glass.png'; // Иконка лупы
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
                              questId: this.questId,
                              foundExhibitsList: this.foundExhibitsList,
                              onAnswerSubmitted: (isCorrect) {
                                setState(() {
                                  _isCardCorrect[questionIndex] = isCorrect;
                                  _checkAllAnswers();
                                },
                                );
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
  }

  void _checkAllAnswers() {
    if (_isCardCorrect.every((isCorrect) => isCorrect)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => userResultScreen(questId: questId, status: "2",),
        ),
      );
    }
  }
}



