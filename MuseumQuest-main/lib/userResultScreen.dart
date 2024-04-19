import 'package:flutter/material.dart';
import 'userHomeScreen.dart';

// import 'main.dart';

class userResultScreen extends StatelessWidget {
  const userResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Результаты', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFF1F1D2B), // Фоновый цвет
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0), // добавляем отступы
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'lib/img/results_image.png',
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Поздравляем! \nНа прохождение квеста\nвам потребовалось ≈ 15 минут',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox( // чтобы кнопка была на всю ширину
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const userHomeScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1AACBC), // цвет кнопки
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4), // закругление углов
                    ),
                  ),
                  child: const Text('Вернуться на главную', style: TextStyle(color: Colors.white)),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
