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

  final List<Question> _quests = DBProvider.dbp.questions;
  Question _quest;
  List<Color> _txtColors;

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

    _quest = _quests[_current];
    _total = _quests.length;
    _txtColors = _quest.answered
        ? _getColors()
        : List.filled(_quest.choices.length, Colors.black);

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
            child: Card(
                child: Scrollbar(
                    child: ListView(
                      children: _getQuestionWidgets() + _getChoicesWidgets(),
                    )))),

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
                  onPressed: _onPressBackward,
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
                  onPressed: _onPressForward,
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }

  /// Iterate over choices for current question
  List<Widget> _getChoicesWidgets() {
    List checkTiles = <CheckboxListTile>[];
    for (int i = 0; i < _quest.choices.length; i++) {
      var choice = _quest.choices[i];
      Text text = Text(choice.choice, style: TextStyle(color: _txtColors[i]));
      var tile = CheckboxListTile(
          value: _quest.choices[i].selected,
          onChanged: (bool value) {
            setState(() {
              _quest.choices[i].selected = value;
              DBProvider.dbp.setChoice(_current, i, value);
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
          title: text);
      checkTiles.add(tile);
    }
    return checkTiles;
  }

  /// Get question, divider and code example if exists
  List<Widget> _getQuestionWidgets() {
    return [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          _quest.question,
          style: Theme
              .of(context)
              .textTheme
              .subhead,
        ),
      ),
      Divider(
        indent: 8,
        endIndent: 8,
      ),
      _quest.code == null
          ? Container()
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(_quest.code),
      )
    ];
  }

  void _onPressForward() {
    if (_current < _total - 1) {
      if (!_quest.answered) {
        _quest.answered = true;
      }
      setState(() {
        DBProvider.dbp.updateQuestion(_quest);
        _current++;
      });
    }
  }

  void _onPressBackward() {
    if (_current > 0) {
      setState(() {
        DBProvider.dbp.updateQuestion(_quest);
        _current--;
      });
    }
  }

  _getColors() {
    List<Color> colors = List(_quest.choices.length);
    for (int i = 0; i < _quest.choices.length; i++) {
      if (_quest.choices[i].selected) {
        if (_quest.choices[i].right) {
          colors[i] = Colors.green;
        } else {
          colors[i] = Colors.red;
        }
      } else {
        colors[i] = Colors.black;
      }
      return colors;
    }
  }
}
