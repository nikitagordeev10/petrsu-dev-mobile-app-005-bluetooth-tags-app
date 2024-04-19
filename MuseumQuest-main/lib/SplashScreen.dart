import 'dart:async';
import 'package:flutter/material.dart';
import 'package:museum_app/userHomeScreen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => userHomeScreen()));
    });
    return Scaffold(
      backgroundColor: Color(0xFF1F1D2B),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Spacer(), // Равномерное распределение пространства сверху и снизу
            Image.asset(
              'lib/img/logo/logo.png',
              width: 130,
              height: 130,
            ),
            SizedBox(height: 10), // Пространство между изображением и текстом
            Text(
              'МузБинго',
              style: TextStyle(
                fontSize: 30, // Увеличение размера текста
                fontWeight: FontWeight.bold, // Жирный шрифт
                color: Colors.white, // Цвет текста
              ),
              textAlign: TextAlign.center, // Центрирование текста
            ),
            Spacer(), // Равномерное распределение пространства сверху и снизу
          ],
        ),
      ),
    );
  }
}
