import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;

// подключение к БД
  void connectToDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Supabase.initialize(
      url: 'https://hpajczznwickbpcpxrik.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhwYWpjenpud2lja2JwY3B4cmlrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQ4ODg0NzcsImV4cCI6MjAzMDQ2NDQ3N30.PsX65kLT8j1wbzHZc6cqo6QbCItKQ4pqkJhLQ9FIHKE',
    );
    final supabase = Supabase.instance.client;
    Future read(table) async {
      final data = await supabase.from(table).select();
      return data;
    }
  }
//String readJson() async {
//  String contents;
//  await Future.wait([
//    getApplicationDocumentsDirectory().then((directory) {
//      final file = File('${directory.path}/progress.json');
//      // Read the file
//      contents = file.readAsStringSync();
//    }),
//  ]);
//  return contents;
//}
  Future readJson() async {
    WidgetsFlutterBinding.ensureInitialized();
    final directory = await getApplicationDocumentsDirectory();
    //final file = await File('${path}/progress.json');
    //final file = await File('${directory.path}/progress.json');
    final file = await File('/data/user/0/com.example.museum_app/app_flutter/progress.json');
    // Read the file
    String contents = await file.readAsString();
    return contents;
  }
//Future<String> readJson() async {
//  WidgetsFlutterBinding.ensureInitialized();
//  final String response = await rootBundle.loadString('lib/progress.json');
//  return response;
//}
String jsonString = '''{
    'Одежда': {
      "quest_id": 1,
      'description': 'Традиционная одежда, вышивка, укращения и ткачество',
      'stat': '0',
      'img': 'lib/img/' + 'background_image_3.jpg',
      // id экспонатов
      'exhibits': {
        // картинка экспонтата, информация про него, первый элемент - флаг (определяем вопрос или метка)
        "quest_1.png": ["q", "Вопрос для первого экспоната (1)?", "1"],
        "quest_2.png": ["q", "Вопрос для первого экспоната (2)?", "2"],
        "quest_3.png": ["q", "Вопрос для первого экспоната (3)?", "3"],
        "quest_4.png": ["q", "Вопрос для первого экспоната (4)?", "4"],
        "quest_5.png": ["q", "Вопрос для первого экспоната (5)?", "5"],
        "quest_6.png": ["q", "Вопрос для первого экспоната (6)?", "6"],
      },
    },

    'Изобретения': {
      "quest_id": 2,
      'description': 'Лодки, инструменты, украшения из меди и многое другое',
      'stat': '1',
      'img': 'lib/img/' + 'background_image_2.jpg',
      // id экспонатов
      'exhibits': {
        // картинка экспонтата, информация про него, первый элемент - флаг (определяем вопрос или метка)
        "quest_1.png": ["q", "Какого века макет?", "18"],
        "quest_2.png": ["q", "Какого века макет?", "18"],
        "quest_3.png": ["q", "Какого века макет?", "18"],
        "quest_4.png": ["q", "Какого века макет?", "18"],
        "quest_5.png": ["q", "Какого века макет?", "18"],
        "quest_6.png": ["q", "Какого века макет?", "18"],
      },
    },

    'Национальные блюда': {
      "quest_id": 3,
      'description': 'Традиционные карельские блюда',
      'stat': '2',
      'img': 'lib/img/' + 'background_image_1.jpg',
      // id экспонатов
      'exhibits': {
        // картинка экспонтата, информация про него, первый элемент - флаг (определяем вопрос или метка)
        "quest_1.png": ["q", "Какого века макет?", "18"],
        "quest_2.png": ["q", "Какого века макет?", "18"],
        "quest_3.png": ["q", "Какого века макет?", "18"],
        "quest_4.png": ["q", "Какого века макет?", "18"],
        "quest_5.png": ["q", "Какого века макет?", "18"],
        "quest_6.png": ["q", "Какого века макет?", "18"],
      },
    },
  }; ''';


//String jsonString = readJson();

// получение информации о квестах с сервера
  Map<String, dynamic> getQuestsInfo(){
    String jsonString="";
    readJson().then((response) {jsonString=response;});
    Map<String, dynamic> result = jsonDecode(jsonString);
    return result;
  }