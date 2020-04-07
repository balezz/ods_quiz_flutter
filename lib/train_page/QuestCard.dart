import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class QuestCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var tile = CheckboxListTile(
        value: false,
        onChanged: (bool value) {},
        controlAffinity: ListTileControlAffinity.leading,
        title: Text(
          'A) First question',
        ));

    return Card(
      child: Scrollbar(
        child: ListView(
          children: <Widget>[
            Text('Hello, question'),
            Divider(),
            Text('Hello, code'),
            tile
          ],
        ),
      ),
    );
  }
}
