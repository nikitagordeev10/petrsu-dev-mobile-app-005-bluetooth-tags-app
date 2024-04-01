import 'package:flutter/material.dart';
import 'package:museum_app/userQuestScreen.dart';

class QuestCard extends StatelessWidget {
  final String questId;
  final String questName;
  final String questDescription;
  // questStatus - флаг прохождения квеста: 0 - не пройден, 1 - пройден
  final String questStatus;
  final String imgSrc;

  QuestCard({required this.questId, required this.questName, required this.questDescription, required this.questStatus, required this.imgSrc});

  void _QuestCardTapped(BuildContext contex) {

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context)
            {
              return userQuestScreen();
            },
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(5),
        height: 125,
        width: MediaQuery.of(context).size.width - 10,
        decoration: BoxDecoration(
          color: questStatus == '0' ? Color(0xff8687e7) : Color(0xff32d74b),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 15, left: 15),
                    child: Text(
                      questStatus == '0' ? questName : questName + '  +',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      questDescription,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                ),
                child: Image.asset(
                  imgSrc, // Путь к изображению квеста
                  // fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height, // Высота изображения половину ширины экрана
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}