import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MaterialApp(
    home: adminQuestEditScreen(),
  ));
}

class adminQuestEditScreen extends StatefulWidget {
  const adminQuestEditScreen({Key? key}) : super(key: key);

  @override
  _adminQuestEditScreenState createState() => _adminQuestEditScreenState();
}

class _adminQuestEditScreenState extends State<adminQuestEditScreen> {
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

  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F1D2B),
      appBar: AppBar(
        title: const Text('Редактирование квеста', style: TextStyle(color: Colors.white)),
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
                'Название квеста:',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: exhibitNameController,
                decoration: const InputDecoration(
                  hintText: 'Название квеста',
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
                'Описание квеста:',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: questionController, // Fixed controller
                decoration: const InputDecoration(
                  hintText: 'Описание квеста',
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
                'Обложка квеста:',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 5),
              // Область для загрузки изображения
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF252836),
                  border: Border.all(
                    color: Colors.white,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: _selectedImage != null
                    ? Image.file(_selectedImage!)
                    : Center(
                  child: Text(
                    'Вставьте изображение',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0), // Отступы 20 пикселей с обеих сторон
                child: Center(
                  child: TextButton(
                    onPressed: _pickImageFromGallery,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.all(12.0),
                      backgroundColor: Color(0xFF1AACBC),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    child: Text(
                      'Загрузить изображение из файлов',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
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
                padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 8.0),
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
                padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 8.0),
              ),
              child: Text('Сохранить', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  void _pickImageFromGallery() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }
}
