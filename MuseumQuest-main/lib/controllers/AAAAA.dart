import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
void main() {
  // Получаем путь к файлу progress.json
  String filePath = getFilePath();
  // Создаем объект File
  File file = File(filePath);
  // Читаем содержимое файла
  String contents = file.readAsStringSync();

  // Распечатываем содержимое файла в консоль
  print(contents);
}