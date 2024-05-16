import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: adminExibitAdd1Screen(),
  ));
}

class adminExibitAdd1Screen extends StatefulWidget {
  const adminExibitAdd1Screen({Key? key}) : super(key: key);

  @override
  _adminExibitAdd1ScreenState createState() => _adminExibitAdd1ScreenState();
}

class _adminExibitAdd1ScreenState extends State<adminExibitAdd1Screen> {
  TextEditingController exhibitNameController = TextEditingController();
  TextEditingController questionController = TextEditingController();
  TextEditingController answerController = TextEditingController();
  List<TextEditingController> additionalAnswerControllers = [];

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
    return Scaffold(
      backgroundColor: const Color(0xFF1F1D2B),
      appBar: AppBar(
        title: const Text('Добавление экспоната', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: _cancel,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Название экспоната:',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: exhibitNameController,
                decoration: const InputDecoration(
                  hintText: 'Введите название экспоната',
                  hintStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Color(0xFF252836),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Фотография экспоната:',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 5),
              // Область для загрузки изображения
              Container(
                height: 150,
                width: double.infinity,
                color: const Color(0xFF252836),
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      // Добавьте функционал для загрузки изображения из файлов
                    },
                    child: const Text(
                      'Загрузить изображение из файлов',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Подтверждение экспоната:',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          confirmationType = "Bluetooth";
                        });
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: confirmationType == "Bluetooth" ? Color(0xFF1AACBC) : Color(0xFF252836),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                      child: const Text(
                        'Bluetooth',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          confirmationType = "Вопрос";
                        });
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: confirmationType == "Вопрос" ? Color(0xFF1AACBC) : Color(0xFF252836),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                      child: const Text(
                        'Вопрос',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),


              if (confirmationType == "Вопрос")
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      'Вопрос для подтверждения экспоната:',
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: questionController,
                      decoration: const InputDecoration(
                        hintText: 'Текст вопроса',
                        hintStyle: TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: Color(0xFF252836),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Ответы для подтверждения экспоната:',
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: answerController,
                      decoration: const InputDecoration(
                        hintText: 'Текст ответа',
                        hintStyle: TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: Color(0xFF252836),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                    for (var controller in additionalAnswerControllers)
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: TextFormField(
                          controller: controller,
                          decoration: const InputDecoration(
                            hintText: 'Дополнительный вариант ответа',
                            hintStyle: TextStyle(color: Colors.white),
                            filled: true,
                            fillColor: Color(0xFF252836),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(4.0)),
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: _addAnswerField,
                          child: const Text('Добавить вариант ответа', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ],
                ),
              if (confirmationType == "Bluetooth")
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      'Выберите метку:',
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    const SizedBox(height: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: const Text('Метка Ruuvi', style: TextStyle(color: Colors.white)),
                          subtitle: const Text('id: 8583841', style: TextStyle(color: Colors.white)),
                          leading: Radio(
                            value: "8583841",
                            groupValue: confirmationType,
                            onChanged: (value) {
                              setState(() {
                                confirmationType = value as String?;
                              });
                            },
                          ),
                          tileColor: confirmationType == "8583841" ? Color(0xFF1AACBC) : Color(0xFF252836),
                        ),
                        ListTile(
                          title: const Text('Метка Ruuvi', style: TextStyle(color: Colors.white)),
                          subtitle: const Text('id: 3740754', style: TextStyle(color: Colors.white)),
                          leading: Radio(
                            value: "3740754",
                            groupValue: confirmationType,
                            onChanged: (value) {
                              setState(() {
                                confirmationType = value as String?;
                              });
                            },
                          ),
                          tileColor: confirmationType == "3740754" ? Color(0xFF1AACBC) : Color(0xFF252836),
                        ),
                        ListTile(
                          title: const Text('Метка Ruuvi', style: TextStyle(color: Colors.white)),
                          subtitle: const Text('id: 7859733', style: TextStyle(color: Colors.white)),
                          leading: Radio(
                            value: "7859733",
                            groupValue: confirmationType,
                            onChanged: (value) {
                              setState(() {
                                confirmationType = value as String?;
                              });
                            },
                          ),
                          tileColor: confirmationType == "7859733" ? Color(0xFF1AACBC) : Color(0xFF252836),
                        ),
                      ],
                    ),

                  ],
                ),
            ],
          ),
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
}