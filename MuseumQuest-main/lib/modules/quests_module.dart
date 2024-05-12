import 'dart:io';
import 'package:flutter/material.dart';
import 'package:museum_app/ui_widgets/quest_widget.dart';
import 'package:museum_app/controllers/db_controller.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';


// возвращает список, содержащий списки вида: [название_кветса, описание_кветса, путь_до_фоновой_картинки]
Future<List<List<String>>> getQuestsInformation() async {
  // "сырая" информация из бд (функция вызывается из db_controller.dart)
  Map<String, dynamic> questsData = {
    'Одежда' : {
      "quest_id": 1,
      'description': 'Традиционная одежда, вышивка, укращения и ткачество',
      'stat': '0',
      'img': 'lib/img/'+'background_image_3.jpg',
      // id экспонатов
      'exhibits' : {
        // картинка экспонтата, информация про него, первый элемент - флаг (определяем вопрос или метка)
        "quest_1.png": ["0", "q", "Вопрос для первого экспоната (1)?", "1"],
        "quest_2.png": ["1", "q", "Вопрос для первого экспоната (2)?", "2"],
        "quest_3.png": ["2", "q", "Вопрос для первого экспоната (3)?", "3"],
        "quest_4.png": ["3", "q", "Вопрос для первого экспоната (4)?", "4"],
        "quest_5.png": ["4", "q", "Вопрос для первого экспоната (5)?", "5"],
        "quest_6.png": ["5", "q", "Вопрос для первого экспоната (6)?", "6"],
      },
    },

    'Изобретения' : {
      "quest_id": 2,
      'description': 'Лодки, инструменты, украшения из меди и многое другое',
      'stat': '1',
      'img': 'lib/img/' + 'background_image_2.jpg',
      // id экспонатов
      'exhibits' : {
        // картинка экспонтата, информация про него, первый элемент - флаг (определяем вопрос или метка)
        "quest_1.png": ["0", "q", "Какого века макет?", "18"],
        "quest_2.png": ["1", "q", "Какого века макет?", "18"],
        "quest_3.png": ["2", "q", "Какого века макет?", "18"],
        "quest_4.png": ["3", "q", "Какого века макет?", "18"],
        "quest_5.png": ["4", "q", "Какого века макет?", "18"],
        "quest_6.png": ["5", "q", "Какого века макет?", "18"],
      },
    },

    'Национальные блюда' : {
      "quest_id": 3,
      'description': 'Традиционные карельские блюда',
      'stat': '2',
      'img': 'lib/img/' + 'background_image_1.jpg',
      // id экспонатов
      'exhibits' : {
        // картинка экспонтата, информация про него, первый элемент - флаг (определяем вопрос или метка)
        "quest_1.png": ["0", "q", "Какого века макет?", "18"],
        "quest_2.png": ["1", "q", "Какого века макет?", "18"],
        "quest_3.png": ["2", "q", "Какого века макет?", "18"],
        "quest_4.png": ["3", "q", "Какого века макет?", "18"],
        "quest_5.png": ["4", "q", "Какого века макет?", "18"],
        "quest_6.png": ["5", "q", "Какого века макет?", "18"],
      },
    },
  };//await readJson();
  // информация для построения виджета квеста
  List<List<String>> questInfoList = [];

  // по всем квестам, где key - название квеста, а value - информация о квесте
  for (final element in questsData.entries)
  {
      var id = element.value['quest_id'].toString();
      String description = element.value['description'];
      String imagePath = element.value['img'];
      String status = element.value['stat'];
      questInfoList.add([id, element.key, description, imagePath, status]);
  }
  return questInfoList;
}

// TODO: функция для получения дельты между скачанными квестами и квестами пользователя


// функция возвращает найденные пользователем экспонаты для одного квеста
Future<List<int>> getFoundExhibits(int questId) async{
  var quests = await readJson();
  List<int> resultList = [];
  for (var quest in quests["quests"])
    if (quest["quest_id"] == questId)
    {
      List<dynamic> foundExhibits = quest["found_exhibits"];
      for(var exhibit in foundExhibits)
      {
        resultList.add(exhibit);
      }
      break;
    }
  return resultList;
}

// функция возвращает статус квеста
Future<String> getQuestStatus(int questId) async{
  var data = await readJson();
  List<dynamic> quests = data['quests'];
  for (var quest in quests)
  {
    if (quest["quest_id"] == questId)
    {
      return quest["status"].toString();
    }
  }
  return "0";
}

Future<void> setQuestStatus(int questId, String newStatus) async
{
  var data = await readJson();
  List<dynamic> quests = data['quests'];
  for (var quest in quests) {
    if (quest["quest_id"] == questId) {
      quest["status"] = newStatus;
      break;
    }
  }
  var data1 = jsonEncode(data);
  final directory = await getApplicationDocumentsDirectory();
  final path = await directory.path;
  final file = await File('$path/progress.json');
  await file.writeAsString(data1);
}