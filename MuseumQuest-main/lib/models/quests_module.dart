import 'package:flutter/material.dart';
import 'package:museum_app/ui_widgets/quest_widget.dart';

// TO-DO: описать получение данных из БД и их передачу в questsWidgetList
Future<List<Widget>> getQuests() async {
  // Map<String, List<String>> questData = {};
  List<Widget> questsWidgetList = [];

  // получаем данные
  /*for (final quest in questData.entries)
  {
    questsWidgetList.add(QuestCard(questId: '1', questName: 'Квест1', questDescription: 'Описание 1'));
  }*/
  questsWidgetList.add(QuestCard(questId: '1', questName: 'Изобретения', questDescription: 'Лодки, инструменты, украшения из меди и многое другое', questStatus: '0', imgSrc: 'lib/img/quest1Img.png'));
  questsWidgetList.add(QuestCard(questId: '2', questName: 'Одежда', questDescription: 'Традиционная одежда, украшения, вышивка и ткачество', questStatus: '1', imgSrc: 'lib/img/quest2Img.png'));
  return questsWidgetList;
}