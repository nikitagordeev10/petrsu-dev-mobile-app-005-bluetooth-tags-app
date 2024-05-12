import 'package:flutter/material.dart';
import 'package:museum_app/modules/exhibit_module.dart';
import 'modules/quests_module.dart';
import 'userHomeScreen.dart';

class userResultScreen extends StatelessWidget {
  final int questId;
  final String status;
  const userResultScreen({Key? key, required this.questId, required this.status}) : super(key: key);

  Future<void> _completeQuest(BuildContext context) async {
    await resetProgress(questId);
    await setQuestStatus(questId, '2');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const userHomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Результаты', style: TextStyle(color: Colors.white)),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        backgroundColor: const Color(0xFF1F1D2B),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'lib/img/results_image.png',
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Поздравляем! \nНа прохождение квеста\nвам потребовалось ≈ 15 минут',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      // Используем FutureBuilder для обработки асинхронных операций
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return FutureBuilder(
                            future: _completeQuest(context),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Center(child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return AlertDialog(
                                  title: Text('Ошибка'),
                                  content: Text('${snapshot.error}'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              } else {
                                return Container(); // Пустой контейнер, так как навигация уже выполнена
                              }
                            },
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1AACBC),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: const Text('Вернуться на главную', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
