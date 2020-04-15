import 'dart:convert';

Question questionFromJson(String str) => Question.fromJson(json.decode(str));

String questionToJson(Question data) => json.encode(data.toJson());

class Question {
  String id;
  String question;
  String code;
  String explanation;
  String answered;
  String ansright;
  List<Choice> choices;

  Question({
    this.id,
    this.question,
    this.code,
    this.explanation,
    this.answered,
    this.ansright,
    this.choices,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    id: json["id"],
    question: json["question"],
    code: json["code"],
    explanation: json["explanation"],
    answered: json["answered"],
    ansright: json["ansright"],
    choices: List<Choice>.from(json["choices"].map((x) => Choice.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "question": question,
    "code": code,
    "explanation": explanation,
    "answered": answered,
    "ansright": ansright,
    "choices": List<dynamic>.from(choices.map((x) => x.toJson())),
  };
}

class Choice {
  String choice;
  String right;
  bool selected;

  Choice({
    this.choice,
    this.right,
    this.selected,
  });

  factory Choice.fromJson(Map<String, dynamic> json) => Choice(
    choice: json["choice"],
    right: json["right"],
    selected: json["selected"] == "1",
  );

  Map<String, dynamic> toJson() => {
    "choice": choice,
    "right": right,
    "selected": selected ? "1" : "0",
  };
}
