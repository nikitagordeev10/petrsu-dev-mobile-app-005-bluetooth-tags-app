import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Функция для чтения данных из JSON файла
  Future<void> readJson() async {
    // Загружаем содержимое JSON файла
    final String response = await rootBundle.loadString('lib/assets/progress.json');

    // Выводим содержимое JSON файла в консоль
    print(response);
  }

  // Вызываем функцию чтения JSON файла
  readJson();
}
