class Quest {
  final int id;
  final String question;
  final String code;
  final String explanation;
  final List choices;
  List checks = <bool>[false, false, false, false];
  int answered = 0;
  int ansright = 0;

  Quest(this.id, this.question, this.choices, this.code, this.explanation );

  Quest.fromJson(Map jsonMap)
      : assert(jsonMap['id'] != null),
        assert(jsonMap['question'] != null),
        assert(jsonMap['choices'] != null),
        id = int.parse(jsonMap['id']),
        question = jsonMap['question'],
        explanation = jsonMap['explanation'],
        code = jsonMap['code'],
        choices = jsonMap['choices'];
}
