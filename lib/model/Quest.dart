import 'dart:convert';

Question questionFromJson(String str) => Question.fromJson(json.decode(str));

String questionToJson(Question data) => json.encode(data.toJson());

class Question {
  int id;
  String question;
  String code;
  String explanation;
  bool answered;
  bool ansright;
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
    id: int.parse(json["id"]),
    question: json["question"],
    code: json["code"],
    explanation: json["explanation"],
    answered: json["answered"] == "1",
    ansright: json["ansright"] == "1",
    choices: [for (var jq in json["choices"])
      Choice.fromJson(jq, int.parse(json["id"]))],
  );

  factory Question.fromSql(Map<String, dynamic> json) => Question(
    id: json["id"],
    question: json["question"],
    code: json["code"],
    explanation: json["explanation"],
    answered: json["answered"] == 1,
    ansright: json["ansright"] == 1,
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

  Map<String, dynamic> toMapSql() => {
    "id": id.toString(),
    "question": question,
    "code": code,
    "explanation": explanation,
    "answered": answered ? 1 : 0,
    "ansright": ansright ? 1 : 0
  };

}

class Choice {
  int qId;
  String choice;
  bool right;
  bool selected;

  Choice({
    this.qId,
    this.choice,
    this.right,
    this.selected,
  });

  factory Choice.fromJson(Map<String, dynamic> json, id) => Choice(
    qId: id,
    choice: json["choice"],
    right: json["right"] == "1",
    selected: json["selected"] == "1",
  );

  Map<String, dynamic> toJson() => {
    "qId": qId,
    "choice": choice,
    "right": right ? "1" : "0",
    "selected": selected ? "1" : "0",
  };
}
