import 'package:flutter/material.dart';
import 'package:odsquiz/flash_page/FlashPage.dart';
import 'package:odsquiz/lecture_page/LecturesPage.dart';
import 'package:odsquiz/train_page//TrainPage.dart';
import 'package:odsquiz/examine_page/ExaminePage.dart';
import 'home_page/HomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ODS Quiz',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/lectures': (context) => LecturesPage(),
        '/flashcards': (context)=> FlashPage(),
        '/training': (context)=> TrainPage(),
        '/examine': (context)=> ExaminePage(),
      },
    );
  }
}
