import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:odsquiz/DBProvider.dart';
import '../model/Quest.dart';

class TrainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TrainPageState();
  }
}

class _TrainPageState extends State<TrainPage> {
  int _total = 1;
  int _current = 0;

  List<Question> _quests = DBProvider.dbp.questions;

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
    _total = _quests.length;
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
        Expanded(child: _getQuestCard()),

        // Button Footer
        Container(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: RawMaterialButton(
                  child: Icon(Icons.chevron_left, color: Colors.white),
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
                  child: Icon(Icons.chevron_right, color: Colors.white),
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

  /// Iterate over choices for current question
  Card _getQuestCard() {
    List checkTiles = <CheckboxListTile>[];
    for (int i = 0; i < _quests[_current].choices.length; i++) {
      var choice = _quests[_current].choices[i];
      var tile = CheckboxListTile(
          value: _quests[_current].choices[i].selected,
          onChanged: (bool value) {
            setState(() {
               _quests[_current].choices[i].selected = value;
               DBProvider.dbp.setChoice(_current, i, value);
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(choice.choice));
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

