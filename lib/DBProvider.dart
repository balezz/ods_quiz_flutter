import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'model/Quest.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  static Database _database;

  List<Question> quests = [];

  Future<Database> get database async {
    if (_database != null)
      return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "QuestDB.db");
    return await openDatabase(path, version: 1,
        onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE Client ("
              "id INTEGER PRIMARY KEY,"
              "first_name TEXT,"
              "last_name TEXT,"
              "blocked BIT"
              ")");
        });
  }

  retrieveQuests(BuildContext context) async {
    final json =
    DefaultAssetBundle.of(context).loadString('assets/json/OdsQuiz.json');
    final questList = JsonDecoder().convert(await json)['questions'];
    for(var quest in questList){
      quests.add(Question.fromJson(quest));
    }
    assert(quests is List<Question>);
    return quests;
  }

  void setChoice(int questIndex, int choiceIndex, bool value) {
    print('todo: data base set question: ${quests[questIndex].question} '
        'choice: ${quests[questIndex].choices[choiceIndex].choice}  value $value');
  }

}
