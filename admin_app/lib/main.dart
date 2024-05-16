import 'package:flutter/material.dart';
import 'package:museum_app/views/user/userHomeScreen.dart';
import 'package:museum_app/views/theme/theme.dart';
import 'package:museum_app/views/system/splashScreen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
    );
  }
}



