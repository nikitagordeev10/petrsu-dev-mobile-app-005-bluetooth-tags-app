import 'dart:io';

import 'package:flutter/material.dart';
import 'package:museum_app/ui_widgets/quest_widget.dart';
import 'package:museum_app/controllers/db_controller.dart';

import 'dart:convert';

// возвращает список, содержащий списки вида: [название_кветса, описание_кветса, путь_до_фоновой_картинки]
List<List<String>> getQuestsInformation() {
  // "сырая" информация из бд (функция вызывается из db_controller.dart)
  Map<String, dynamic> questsData = getQuestsInfo();
  // информация для построения виджета квеста
  List<List<String>> questInfoList = [];

  // по всем квестам, где key - название квеста, а value - информация о квесте
  for (final element in questsData.entries)
  {
      String id = element.value['quest_id'].toString();
      String description = element.value['description'];
      String imagePath = element.value['img'];
      String status = element.value['stat'];
      questInfoList.add([id, element.key, description, imagePath, status]);
  }

  return questInfoList;
}

// TODO: функция для получения дельты между скачанными квестами и квестами пользователя


// функция возвращает найденные пользователем экспонаты для одного квеста
List<int> getFoundExhibits(int questId) {
  // считываем данные из json файла
  // File file = File('lib/assets/progress.json');
  // String jsonString = file.readAsStringSync();

  // Map<String, dynamic> jsonData = jsonDecode(jsonString);

  var jsonData = jsonString;

  var quests = jsonDecode(jsonData);
  List<int> resultList = [];

  for (var quest in quests["quests"])
    if (quest["quest_id"] == questId)
    {
      List<dynamic> foundExhibits = quest["found_exhibits"];
      
      for(var exhibit in foundExhibits)
      {
        resultList.add(exhibit);
      }
    }

  return resultList;
}

// функция по нахождению информации о квесте (название/описание/статус)

