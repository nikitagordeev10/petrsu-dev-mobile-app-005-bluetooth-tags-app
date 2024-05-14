import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:io';
import 'dart:convert';
//import '/assets/progress.json';
import 'package:flutter/services.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('lib/assets/progress.json');
    //final data = await json.decode(response);
    //String jsonString = data;
    print(response);
  }
  readJson();
}
