import 'dart:convert';
import 'package:flutter/material.dart';
import '../controllers/dbСontroller.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:museum_app/views/ui_widgets/questWidget.dart';
import 'dart:convert';

Future<List<bool>> getCorrectCardList(List<int> foundExhibitsList) async{
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
Future<void> saveProgress(int index, int questId) async
{
  var data = await readJson();
  List<dynamic> quests = data['quests'];
  for (var quest in quests)
  {
    if (quest["quest_id"] == questId)
    {
      quest["found_exhibits"].add(index+1);
      break;
    }
  }
  var data1 = jsonEncode(data);
  final directory = await getApplicationDocumentsDirectory();
  final path = await directory.path;
  final file = await File('$path/progress.json');
  await file.writeAsString(data1);
}

// сброс прогресса
Future<void> resetProgress(int questId) async
{
  var data = await readJson();
  List<dynamic> quests = data['quests'];
  for (var quest in quests)
  {
    if (quest["quest_id"] == questId)
    {
      quest["found_exhibits"] = [];
      break;
    }
  }
  var data1 = jsonEncode(data);
  final directory = await getApplicationDocumentsDirectory();
  final path = await directory.path;
  final file = await File('$path/progress.json');
  await file.writeAsString(data1);
}