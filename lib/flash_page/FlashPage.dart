import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flip_card/flip_card.dart';

class FlashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flashcards'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            child: Container(
              height: 40,
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: LinearProgressIndicator(
                      value: 0.5,
                    ),
                    flex: 3,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('3 from 63'),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: FlipCard(
              direction: FlipDirection.HORIZONTAL,
              front: Card(
                child: Container(
                  height: 400,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Center(
                          child: Text('Hello, flash card!',
                              style: Theme.of(context).textTheme.headline),
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
                          child: Text('Hello, data scientist!',
                              style: Theme.of(context).textTheme.headline),
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
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        backgroundColor: Colors.blue,
        child: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
