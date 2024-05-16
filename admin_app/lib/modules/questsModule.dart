import 'dart:io';
import 'package:flutter/material.dart';
import 'package:museum_app/views/ui_widgets/questWidget.dart';
import 'package:museum_app/controllers/dbСontroller.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;

// переменные для таймера
int startTime = 0, finishTime = 0, resultTime = 0;

// возвращает список, содержащий списки вида: [название_квеста, описание_квеcта, путь_до_фоновой_картинки]
Future<List<List<String>>> getQuestsInformation() async {
  // Загрузка JSON-файла из папки assets
  final data = await rootBundle.load('lib/database/quests.json');

  // Декодирование JSON
  String questsData = utf8.decode(data.buffer.asUint8List());
  Map<String, dynamic> questsJson = jsonDecode(questsData);

  // Информация для построения виджета квеста
  List<List<String>> questInfoList = [];

  // По всем квестам, где key - название квеста, а value - информация о квесте
  for (final entry in questsJson.entries) {
    var id = entry.value['quest_id'].toString();
    String description = entry.value['description'].toString();
    String imagePath = entry.value['img'].toString();
    String status = entry.value['stat'].toString();
    String exhibits = entry.value['exhibits'].toString();
    questInfoList.add([id, entry.key, description, imagePath, status, exhibits]);
  }
  return questInfoList;
}

// TODO: функция для получения дельты между скачанными квестами и квестами пользователя


// функция получения списка айдишников экспонатов для квеста
Future<List<int>> getQuestExhibits(int questId) async {
  List<int> exhibitList = [];
  List<List<String>> questInfo = await getQuestsInformation();

  for (int i = 0; i < questInfo.length; i++)
    {
      if (questId == int.parse(questInfo[i][0]))
        {
          final String exhibitDynamic = questInfo[i][5];
          exhibitList = exhibitDynamic
              .replaceAll('[', '')
              .replaceAll(']', '')
              .split(', ')
              .map(int.parse)
              .toList();
        }
    }

  return exhibitList;
}

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

// получение информации о квесте
Future<String> getQuestInfo(int questId,
    {
      String? questInfo
    }
    )
async {
  var data = await readJson();

  List<dynamic> quests = data['quests'];
  for (var quest in quests)
  {
    if (quest["quest_id"] == questId)
    {
      switch(questInfo)
      {
        case "status":
          return quest["status"].toString();
        case "time":
          return quest["completion_time"].toString();
        default:
          return '';
      }
    }
  }
  return '';
}

// ------------------------------ таймер ------------------------------
void startTimer() {
  startTime = DateTime.now().millisecondsSinceEpoch;
}

void stopTimer() {
  finishTime = DateTime.now().millisecondsSinceEpoch;
}

Future<void> setQuestTime(int questId, Future<int> resultTimeF) async
{
  int resultTime = await resultTimeF;
  var data = await readJson();
  List<dynamic> quests = data['quests'];
  for (var quest in quests) {
    if (quest["quest_id"] == questId) {
      quest["completion_time"] = resultTime;
      break;
    }
  }
  var data1 = jsonEncode(data);
  final directory = await getApplicationDocumentsDirectory();
  final path = await directory.path;
  final file = await File('$path/progress.json');
  await file.writeAsString(data1);
}

// переделать функцию на void????
Future<int> getResultTime(int questId)
async {
  int prevResultTime = 0;
  String prevQuestTime = await getQuestInfo(questId, questInfo: "time");

  // если квест был продолжен, то получаем предыдущее время прохождения
  if (await getQuestInfo(questId, questInfo: "status") == '1')
  {
    if(prevQuestTime != 'null')
    {
      prevResultTime = int.parse(prevQuestTime);
    }
  }

  if (startTime != 0 && finishTime != 0)
  {
    // получаем результат в минутах
    resultTime = (prevResultTime + (finishTime - startTime) ~/ 60000);
    // записываем результат в минутах
     setQuestTime(questId, Future.value(resultTime));
    // возвращаем результат в минутах
    return resultTime;
  }
  return 0;
}

Future<String> getMessage(int questId) async {
  if (resultTime != null)
  {
    if (await getResultTime(questId) == 0)
      return 'Поздравляем! \nНа прохождение квеста\nвам потребовалось меньше минуты!';
    return 'Поздравляем! \nНа прохождение квеста\nвам потребовалось ≈ $resultTime мин';
  }
  return '';
}