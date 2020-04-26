import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'model/Quest.dart';

const String QUESTIONS_TABLE_NAME = 'questions';
const String CHOICES_TABLE_NAME = 'choices';

class DBProvider {
  DBProvider._();

  static final DBProvider dbp = DBProvider._();

  static Database _database;

  List<Question> questions = [];

  Future<Database> initDB() async {
    print('initDB() invoked');
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "QuestDB.db");
    Database db = await openDatabase(path,
        version: 1, onOpen: (db) {}, onCreate: _initTables);
    print("Database initialized: $db");
    return db;
  }

  Future<void> _initTables(Database db, int version) async {
    print('_initTables() invoked');
    await db.execute("CREATE TABLE $QUESTIONS_TABLE_NAME ("
        "id INTEGER PRIMARY KEY,"
        "question TEXT,"
        "code TEXT,"
        "explanation TEXT,"
        "answered INTEGER,"
        "ansright INTEGER"
        ")");
    await db.execute("CREATE TABLE $CHOICES_TABLE_NAME ("
        "_id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "choice TEXT,"
        "right INTEGER,"
        "selected INTEGER,"
        "qid INTEGER"
        ")");
  }

  Future<List<Question>> getQuestions(BuildContext context) async {
    print('getQuestions() invoked');
    if (_database == null) {
      _database = await initDB();
      questions = await readQuestions();
    }
    if (questions.isEmpty) {
      questions = await retrieveQuestsJson(context);
    }
    return questions;
  }

  retrieveQuestsJson(BuildContext context) async {
    print('retrieveQuestsJson() invoked');
    final json =
        DefaultAssetBundle.of(context).loadString('assets/json/OdsQuiz.json');
    final questList = JsonDecoder().convert(await json)['questions'];
    for (var quest in questList) {
      questions.add(Question.fromJson(quest));
    }
    assert(questions is List<Question>);
    return questions;
  }

  // Repository methods //

  Future<Question> insertQuestion(Question question) async {
    question.id =
        await _database.insert(QUESTIONS_TABLE_NAME, question.toMapSql());
    return question;
  }

  Future<Question> updateQuestion(Question question) async {
    print('updateQuestion() invoked');
    question.id = await _database.update(
      QUESTIONS_TABLE_NAME,
      question.toMapSql(),
      where: 'id = ?',
      whereArgs: [question.id]);
    for(var choice in question.choices){
      _database.update(CHOICES_TABLE_NAME, choice.toJson());
    }
    return question;
  }

  Future<void> insertQuestions(List<Question> quests) async {
    print('insertQuestions() invoked, $quests inserting...');
    for (Question question in quests) {
      question = await insertQuestion(question);
      for (Choice choice in question.choices) {
        insertChoice(choice);
      }
      print('Question ${question.id} inserted');
    }
  }

  Future<List<Question>> readQuestions() async {
    print('readQuestions() invoked');
    List<Map<String, dynamic>> sqlQuestions =
        await _database.query(QUESTIONS_TABLE_NAME);
    for (var sqlQuestion in sqlQuestions) {
      Question question = Question.fromSql(sqlQuestion);
      question.choices = await readChoices(question.id);
      questions.add(question);
      print('sqlQuestion ${sqlQuestion['id']} was read from database');
    }
    return questions;
  }

  Future<Choice> insertChoice(Choice choice) async {
    choice.qId = await _database.insert(CHOICES_TABLE_NAME, choice.toJson());
    return choice;
  }

  /// return from database all choices with defined questionId
  Future<List<Choice>> readChoices(int questId) async {
    List<Map<String, dynamic>> sqlChoices = await _database
        .query(CHOICES_TABLE_NAME, where: 'qId = ?', whereArgs: [questId]);
    List<Choice> choices = [];
    for (var choice in sqlChoices) {
      choices.add(Choice.fromJson(choice, questId));
    }
    return choices;
  }

  void setChoice(int questIndex, int choiceIndex, bool value) {
    print('todo: data base set question: ${questions[questIndex].question} '
        'choice: ${questions[questIndex].choices[choiceIndex].choice}  value $value');
  }
}
