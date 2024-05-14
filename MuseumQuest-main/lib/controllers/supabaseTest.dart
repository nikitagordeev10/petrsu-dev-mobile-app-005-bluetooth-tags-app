import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  // Обязательно инициализируем приложение Flutter
  WidgetsFlutterBinding.ensureInitialized();

  // Инициализируем Supabase с URL и ключом доступа
  await Supabase.initialize(
    url: 'https://hpajczznwickbpcpxrik.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhwYWpjenpud2lja2JwY3B4cmlrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQ4ODg0NzcsImV4cCI6MjAzMDQ2NDQ3N30.PsX65kLT8j1wbzHZc6cqo6QbCItKQ4pqkJhLQ9FIHKE',
  );

  // Экземпляр Supabase Client
  final supabase = Supabase.instance.client;

  // Функция для чтения данных из таблицы
  Future read() async {
    // Выбираем все данные из таблицы 'tblExhibit'
    final userData = await supabase.from('tblExhibit').select();
    print(userData);
    return userData;
  }

  // Вызываем функцию чтения данных
  read();
}
