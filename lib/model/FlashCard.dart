class FlashCard {
  final String front;
  final String back;

  const FlashCard(this.front, this.back);

  FlashCard.fromJson(Map jsonMap)
      : assert(jsonMap['front'] != null),
        assert(jsonMap['back'] != null),
        front = jsonMap['front'],
        back = jsonMap['back'];
}
