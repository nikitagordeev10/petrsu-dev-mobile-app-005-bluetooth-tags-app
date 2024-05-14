import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:museum_app/modules/tags.dart';
import 'adminTagsScreen.dart';

class adminTagAddScreen extends StatefulWidget {
  const adminTagAddScreen({Key? key}) : super(key: key);

  @override
  _adminTagAddScreenState createState() => _adminTagAddScreenState();
}

class _adminTagAddScreenState extends State<adminTagAddScreen> {
  TextEditingController tagNameController = TextEditingController();
  TextEditingController tagIDController = TextEditingController();
  TextEditingController tagStatusController = TextEditingController();

  String? confirmationType;

  void _addExhibit() {
    // Your logic for adding exhibit here
  }

  void _cancel() {
    Navigator.of(context).pop();
  }

  void _save() {
    // Your logic for saving exhibit here
    Navigator.of(context).pop(Tag(
      name: tagNameController.text.trim(),
      id: tagIDController.text.trim(),
      status: tagStatusController.text.trim(),
    ));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F1D2B),
      appBar: AppBar(
        title: const Text('Добавление метки', style: TextStyle(color: Colors.white)),
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
                'Название метки:',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: tagNameController,
                decoration: const InputDecoration(
                  hintText: 'Название метки',
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
                'id метки:',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: tagIDController,
                decoration: const InputDecoration(
                  hintText: 'id метки',
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
                'Экспонат:',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: tagStatusController,
                decoration: const InputDecoration(
                  hintText: 'экспонат',
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


}
