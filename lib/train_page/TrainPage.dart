import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'Quest.dart';

class TrainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TrainPageState();
  }
}

class _TrainPageState extends State<TrainPage> {
  int _total = 1;
  int _current = 0;
  List<Quest> _quests = [];

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
    final json =
        DefaultAssetBundle.of(context).loadString('assets/json/OdsQuiz.json');
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
        Expanded(child: getQuestCard()),

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

  Card getQuestCard() {
    List checkTiles = <CheckboxListTile>[];
    for (int i = 0; i < _quests[_current].choices.length; i++) {
      var choice = _quests[_current].choices[i];
      var tile = CheckboxListTile(
          value: _quests[_current].checks[i],
          onChanged: (bool value) {
            setState(() {
               _quests[_current].checks[i] = value;
              print(i);
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(choice['choice']));
      checkTiles.add(tile);
    }

    return Card(
      child: Scrollbar(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(_quests[_current].question, style: Theme.of(context).textTheme.subhead,),
            ),
            Divider(indent: 8, endIndent: 8,),
            _quests[_current].code == null
                ? Container()
                : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(_quests[_current].code),
                ),
          ] + checkTiles,
        ),
      ),
    );
  }
}

