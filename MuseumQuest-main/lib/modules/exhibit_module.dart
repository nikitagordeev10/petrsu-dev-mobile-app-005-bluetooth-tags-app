import 'dart:convert';
import 'package:flutter/material.dart';
import '../controllers/db_controller.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:museum_app/ui_widgets/quest_widget.dart';

List<bool> getCorrectCardList(List<int> foundExhibitsList) {
  List<bool> correctCardList = [];

  for (int i = 0; i < 6; i++)
    correctCardList.add(false);

  if (foundExhibitsList.length != 0)
    for (int i in foundExhibitsList)
      correctCardList[i-1] = true;

  return correctCardList;
}

// сохранение прогресса (запись экспоната с индексом index в переменную found_exhibits json файла)
// TODO поработать со статусами квеста
void saveProgress(int index, int questId) async
{
  var data = getQuestsInfo();
  List<dynamic> quests = data['quests'];
  for (var quest in quests)
  {
    if (quest["quest_id"] == questId)
    {
      quest["found_exhibits"].add(index+1);
      break;
    }
  }
  final directory = await getApplicationDocumentsDirectory();
  final path = await directory.path;
  final file = await File('$path/progress.json');
  file.writeAsString('$data');
}

// сброс прогресса
void resetProgress(int questId) async
{
  var data = getQuestsInfo();
  List<dynamic> quests = data['quests'];
  for (var quest in quests)
  {
    if (quest["quest_id"] == questId)
    {
      quest["found_exhibits"] = [];
      break;
    }
  }
  final directory = await getApplicationDocumentsDirectory();
  final path = await directory.path;
  final file = await File('$path/progress.json');
  file.writeAsString('$data');
}