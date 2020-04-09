import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:odsquiz/train_page/Quest.dart';
import 'package:odsquiz/train_page/QuestCard.dart';

class TrainPage extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return _TrainPageState();
  }
}

class _TrainPageState extends State<TrainPage> {
  StreamController<Quest> _controller = StreamController<Quest>();

  int _total = 1;
  int _current = 0;
  List _quests = <Quest>[];


  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (_quests.isEmpty) {
      await _retrieveQuests();
    }
    setState(() {
      _total = _quests.length;
    });
  }

  Future<void> _retrieveQuests() async {
    final json = DefaultAssetBundle.of(context)
        .loadString('assets/json/OdsQuiz.json');
    final questList = JsonDecoder().convert(await json)['questions'];
    assert(questList is List);
    print(questList);
    for (final item in questList) {
      _quests.add(Quest.fromJson(item));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_quests.isEmpty) {
      return Center(
        child: Container(
          height: 180.0,
          width: 180.0,
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Training'),
      ),
      body: Column(children: <Widget>[

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

        // Quest Card
        Expanded(
          child: QuestCard(stream: _controller.stream, quest: _quests[_current],)
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
                        _controller.add(_quests[_current]);
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
                        _controller.add(_quests[_current]);
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
