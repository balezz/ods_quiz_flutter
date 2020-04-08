import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flip_card/flip_card.dart';
import 'package:odsquiz/flash_page/FlashCard.dart';

class FlashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FlashPageState();
  }
}

class _FlashPageState extends State<FlashPage> {
  int _total = 0;
  int _current = 0;
  final _flashCards = <FlashCard>[];

  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (_flashCards.isEmpty) {
      await _retrieveFlashCards();
    }
    setState(() {
      _total = _flashCards.length;
    });
  }

  Future<void> _retrieveFlashCards() async {
    final json = DefaultAssetBundle.of(context)
        .loadString('assets/json/FlashCards.json');
    final cardsList = JsonDecoder().convert(await json)['FlashCards'];
    assert(cardsList is List);
    print(cardsList);
    for (final item in cardsList) {
      _flashCards.add(FlashCard.fromJson(item));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flashcards'),
      ),
      body: Column(
        children: <Widget>[
          // Top info card
          Card(
            child: Container(
              height: 40,
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: LinearProgressIndicator(
                      value: (_current + 1) / _total,
                    ),
                    flex: 3,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('${_current + 1} from $_total'),
                  ),
                ],
              ),
            ),
          ),

          // Main body flashcard view
          Expanded(
            child: Padding(
                padding: EdgeInsets.all(8),
                child: FlipCard(
                  key: cardKey,
                  direction: FlipDirection.HORIZONTAL,
                  front: Card(
                    child: Container(
                      height: 400,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Center(
                              child: Text(_flashCards[_current].front,
                                  style: Theme.of(context).textTheme.headline,
                              textAlign: TextAlign.center,),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text('Rotate me'),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  back: Card(
                    child: Container(
                      height: 400,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Center(
                              child: Text(_flashCards[_current].back,
                                  style: Theme.of(context).textTheme.headline,
                              textAlign: TextAlign.center,),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text('Rotate me'),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )),
          ),

          // Button Footer
          Container(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: RawMaterialButton(
                    child: Icon(Icons.arrow_back_ios, color: Colors.white),
                    fillColor: Colors.blue,
                    shape: CircleBorder(),
                    elevation: 2.0,
                    padding: EdgeInsets.all(16.0),
                    onPressed: () {
                      if (_current > 0) {
                        setState(() {
                          _current--;
                          _resetFlipCard();
                        });
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: RawMaterialButton(
                    child: Icon(Icons.arrow_forward_ios, color: Colors.white),
                    fillColor: Colors.blue,
                    shape: CircleBorder(),
                    elevation: 2.0,
                    padding: EdgeInsets.all(16.0),
                    onPressed: () {
                      if (_current < _total - 1) {
                        setState(() {
                          _current++;
                          _resetFlipCard();
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _resetFlipCard() {
    if(!cardKey.currentState.isFront)
      cardKey.currentState.toggleCard();
  }
}
