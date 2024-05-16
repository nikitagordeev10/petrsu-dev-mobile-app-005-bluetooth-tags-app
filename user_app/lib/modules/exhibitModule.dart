import 'dart:convert';
import 'package:flutter/material.dart';
import '../controllers/dbСontroller.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:museum_app/views/ui_widgets/questWidget.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:museum_app/modules/questsModule.dart';

// получение списка всех экспонатов
Future<List<List<String>>> getExhibitsInfo() async {
  // Загрузка JSON-файла из папки assets
  final data = await rootBundle.load('lib/database/exhibit.json');

  // Декодирование JSON
  String questsData = utf8.decode(data.buffer.asUint8List());
  Map<String, dynamic> exhibitJson = jsonDecode(questsData);

  List<List<String>> exhibitsList = [];

  for (final entry in exhibitJson.entries) {
    var id = entry.value["id"].toString();
    String name = entry.key.toString();
    String description = entry.value["description"].toString();
    String imgPath = entry.value["img"].toString();
    String textQuestion = entry.value["textQuestion"].toString();
    String textQuestionAnswer = entry.value["textQuestionAnswer"].toString();
    String checkingByBluetoothTag =
        entry.value["checkingByBluetoothTag"].toString();
    String idBluetoothTag = entry.value["idBluetoothTag"].toString();

    exhibitsList.add([
      id,
      name,
      description,
      imgPath,
      textQuestion,
      textQuestionAnswer,
      checkingByBluetoothTag,
      idBluetoothTag
    ]);
  }

  return exhibitsList;
}

Future<List<bool>> getCorrectCardList(List<int> foundExhibitsList) async {
  List<bool> correctCardList = [];
  for (int i = 0; i < 6; i++) correctCardList.add(false);

  if (foundExhibitsList.length != 0)
    for (int i in foundExhibitsList) correctCardList[i - 1] = true;

  return correctCardList;
}

Future<void> saveProgress(int index, int questId) async {
  var data = await readJson();
  List<dynamic> quests = data['quests'];
  for (var quest in quests) {
    if (quest["quest_id"] == questId) {
      quest["found_exhibits"].add(index + 1);
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
Future<void> resetProgress(int questId) async {
  var data = await readJson();
  List<dynamic> quests = data['quests'];
  for (var quest in quests) {
    if (quest["quest_id"] == questId) {
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

//получение информации об экспонате по его айди
Future<List<String>> getExhibitInfo(int id) async {
  List<String> exhibitInfo = [];

  List<List<String>> exhList = await getExhibitsInfo();

  for (var exh in exhList) {
    if (int.parse(exh[0]) == id) {
      exhibitInfo.addAll(exh);
    }
  }

  return exhibitInfo;
}

// комбинация двух функций getCorrectCardList и getQuestExhibits для futurebuilder
Future<List<dynamic>> getEhxibitCombineInfo(
    List<int> foundExhibitsList, int questId) async {
  List<bool> correctCardList = await getCorrectCardList(foundExhibitsList);
  List<int> questExhibits = await getQuestExhibits(questId);

  List<List<dynamic>> exhibitsInfo = [];
  for (int i in questExhibits) {
    List<String> exhInfo = await getExhibitInfo(i);
    exhibitsInfo.add(exhInfo);
  }

  print("correctCardList" + correctCardList.toString());
  print("exhibitsInfo" + exhibitsInfo.toString());

  return [correctCardList, exhibitsInfo];
}
