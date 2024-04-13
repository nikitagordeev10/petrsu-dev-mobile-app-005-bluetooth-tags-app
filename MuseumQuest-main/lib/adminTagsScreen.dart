import 'package:flutter/material.dart';

class AdminTagsScreen extends StatelessWidget {
  const AdminTagsScreen ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Метки', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildLabelCard(),
          buildLabelCard(),
          buildLabelCard(),
        ],
      ),
    );
  }

  Widget buildLabelCard() {
    return Card(
      margin: const EdgeInsets.all(16),
      color: const Color(0xFF252836),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            title: const Text(
              'Метка Ruuvi',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'id: 8583841',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  'статус: свободна',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 10),
                backgroundColor: Colors.transparent, // Убираем заливку кнопки
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: const Color(0xFFEA5F5F), width: 1),
                  borderRadius: BorderRadius.zero,
                ),
              ),
              child: Center(
                child: Text(
                  'Удалить',
                  style: TextStyle(color: const Color(0xFFEA5F5F)), // Цвет текста кнопки
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AdminTagsScreen(),
  ));
}
