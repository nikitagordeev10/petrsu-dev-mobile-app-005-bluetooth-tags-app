import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: AdminExhibitEdit2Screen(),
  ));
}

class Exhibit {
  final int questNumber;
  bool isCorrect;

  Exhibit(this.questNumber, {this.isCorrect = false});
}

class AdminExhibitEdit2Screen extends StatefulWidget {
  const AdminExhibitEdit2Screen({Key? key}) : super(key: key);

  @override
  _AdminExhibitEdit2ScreenState createState() => _AdminExhibitEdit2ScreenState();
}

class _AdminExhibitEdit2ScreenState extends State<AdminExhibitEdit2Screen> {
  TextEditingController exhibitNameController = TextEditingController();
  TextEditingController questionController = TextEditingController();
  TextEditingController answerController = TextEditingController();
  List<TextEditingController> additionalAnswerControllers = [];
  List<Exhibit> exhibits = List.generate(6, (index) => Exhibit(index + 1));

  String? confirmationType;

  void _addExhibit() {
    String exhibitName = exhibitNameController.text.trim();
    String question = questionController.text.trim();
    String answer = answerController.text.trim();
    // Дополнительная логика для добавления экспоната
  }

  void _cancel() {
    Navigator.of(context).pop();
  }

  void _save() {
    _addExhibit();
    Navigator.of(context).pop();
  }

  void _addAnswerField() {
    setState(() {
      additionalAnswerControllers.add(TextEditingController());
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = (screenWidth - 40) / 2; // Делим ширину экрана пополам и вычитаем отступы между карточками
    double cardHeight = cardWidth + 45; // Высота карточки равна ширине изображения плюс высота кнопки

    return Scaffold(
      backgroundColor: const Color(0xFF1F1D2B),
      appBar: AppBar(
        title: const Text('Изменение экспоната', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: _cancel,
        ),
      ),

      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Выберите до 6 экспонатов для вашего квеста:',
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),

            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Wrap(
                    alignment: WrapAlignment.spaceEvenly,
                    children: exhibits.map((exhibit) {
                      int questNumber = exhibit.questNumber;
                      int questionIndex = questNumber - 1;
                      return _buildExhibitCard(
                        context,
                        questNumber,
                        questionIndex, // Передаём индекс вопроса
                        cardWidth,
                        cardHeight,
                        exhibit.isCorrect,
                            () {
                          setState(() {
                            exhibit.isCorrect = true;
                          });
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: _cancel,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                side: BorderSide(color: Colors.white),
                backgroundColor: Colors.transparent,
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              ),
              child: Text('Отменить', style: TextStyle(color: Colors.white)),
            ),

            ElevatedButton(
              onPressed: _save,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                backgroundColor: Color(0xFF1AACBC),
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              ),
              child: Text('Сохранить', style: TextStyle(color: Colors.white)),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildExhibitCard(
      BuildContext context,
      int questNumber,
      int questionIndex, // Индекс вопроса
      double cardWidth,
      double cardHeight,
      bool isCorrect,
      VoidCallback onTap,
      ) {
    final String imagePath = 'lib/views/img/quest/quest_$questNumber.png';
    final String magnifyingGlassIcon = 'lib/views/img/icons/magnifying_glass.png'; // Иконка лупы
    final String deleteIcon = 'lib/views/img/icons/delete_small.png'; // Иконка удаления
    final String editIcon = 'lib/views/img/icons/edit.png'; // Иконка редактирования

    return Container(
      width: cardWidth,
      height: cardHeight,
      margin: EdgeInsets.all(8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 4,
        color: isCorrect ? Colors.green : null,
        child: Stack(
          alignment: Alignment.topRight,
          // Выравниваем иконки в правом верхнем углу
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: onTap,
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
                if (isCorrect)
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
                if (!isCorrect)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: cardWidth - 30, // Измените ширину в соответствии с вашим дизайном
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 10.0), // Измените в соответствии с вашим дизайном
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            side: BorderSide(width: 1.0, color: Color(0xFF1AACBC)),
                          ),
                          onPressed: onTap,
                          child: Text(
                            'Не выбрано',
                            style: TextStyle(color: Color(0xFF1AACBC)),
                          ),
                        ),
                      ),
                    ],
                  )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: onTap,
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
}
