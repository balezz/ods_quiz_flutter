import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

import 'CenterCard.dart';
import 'TopCard.dart';
import 'BottomCard.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  final String title = 'Open Data Science Quiz';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TopCard(),
              CenterCard(),
              BottomCard()
            ],
          ),
        ),
      ),
    );
  }
}


