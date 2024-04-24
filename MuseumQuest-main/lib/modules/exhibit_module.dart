import 'package:flutter/material.dart';

List<bool> getCorrectCardList(List<int> foundExhibitsList) {
  List<bool> correctCardList = [];

  for (int i = 0; i < 6; i++)
    correctCardList.add(false);

  if (foundExhibitsList.length != 0)
    for (int i in foundExhibitsList)
      correctCardList[i-1] = true;

  return correctCardList;
}