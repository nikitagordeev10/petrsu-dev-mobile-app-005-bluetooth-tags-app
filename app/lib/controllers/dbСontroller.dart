import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Подключение к БД
void connectToDB() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://hpajczznwickbpcpxrik.supabase.co',
    anonKey:
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhwYWpjenpud2lja2JwY3B4cmlrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQ4ODg0NzcsImV4cCI6MjAzMDQ2NDQ3N30.PsX65kLT8j1wbzHZc6cqo6QbCItKQ4pqkJhLQ9FIHKE',
  );
}

// Функция для чтения данных из файла JSON
Future<Map<String, dynamic>> readJson() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/progress.json');

  // Если файл существует, читаем данные из него
  if (await file.exists()) {
    String contents = await file.readAsString();
    Map<String, dynamic> jsonMap = jsonDecode(contents);
    return jsonMap;
  } else {
    // Если файла нет, копируем его из assets и затем читаем данные
    ByteData data = await rootBundle.load('lib/assets/progress.json');
    await file.writeAsBytes(data.buffer.asUint8List());
    String contents = await file.readAsString();
    Map<String, dynamic> jsonMap = jsonDecode(contents);
    return jsonMap;
  }
}
