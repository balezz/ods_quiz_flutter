import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:odsquiz/train_page/Quest.dart';


class QuestCard extends StatefulWidget {
  final Stream<Quest> stream;
  final Quest quest;

  QuestCard({this.stream, this.quest});


  @override
  State<StatefulWidget> createState() {
    print('Create new QuestPage state! ');
    return _QuestCardState(quest);
  }


}

class _QuestCardState extends State<QuestCard>{
  Quest _quest;
  List _values = [false, false, false];
  _QuestCardState(this._quest);


  void _updateQuest(Quest quest){
    setState(() {
      _quest = quest;
    });
  }

  @override
  void initState() {
    super.initState();
    widget.stream.listen((onData){
      _updateQuest(onData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Scrollbar(
        child: ListView(
          children: [
            Text(_quest.question),
            Divider(),
            _quest.code == null ? Container() : Text(
                _quest.code),
          ] + _getCheckBoxTiles(),
        ),
      ),
    );
  }

  List<StatelessWidget> _getCheckBoxTiles() {
    return [CheckboxListTile(
        value: _quest.checks[0],
        onChanged: (value) {
          setState(() {
            _quest.checks[0] = value;
          });
        },
        controlAffinity: ListTileControlAffinity.leading,
        title: Text(
            _quest.choices[0]['choice']
        )),
      CheckboxListTile(
          value: _quest.checks[1],
          onChanged: (value) {
            setState(() {
              _quest.checks[1] = value;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(
              _quest.choices[1]['choice']
          ))
    ];
  }

}