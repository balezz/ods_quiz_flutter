import 'package:flutter/material.dart';
import 'package:odsquiz/ui/FlashPage.dart';
import 'package:odsquiz/ui/LecturesPage.dart';
import 'package:odsquiz/ui/TrainPage.dart';
import 'package:odsquiz/ui/ExaminePage.dart';
import 'package:odsquiz/ui/HomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ODS Quiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
