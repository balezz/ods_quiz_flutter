import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'QuestCard.dart';

class TrainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Training'),
      ),
      body: Column(children: <Widget>[
        Card(
          child: Container(
            height: 40,
            child: Row(
              children: <Widget>[
                Flexible(
                  child: LinearProgressIndicator(
                    value: 0.15,
                  ),
                  flex: 3,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text('3 from 20'),
                ),
              ],
            ),
          ),
        ),
        Flexible(
          flex: 99,
          child: QuestCard(),
        ),
        ButtonFooter()
      ]),
    );
  }
}

class ButtonFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
              onPressed: () {},
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
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
