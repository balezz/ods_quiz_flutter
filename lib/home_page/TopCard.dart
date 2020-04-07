import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TopCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TopCardState();
  }
}

class _TopCardState extends State<TopCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
              child: Text('My progress',
              style: TextStyle(color: Colors.blue, fontSize: 24),)),
          Divider(
            indent: 8,
            endIndent: 8,
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipOval(
                  child: Container(
                    color: Colors.lightBlue,
                    height: 60,
                    width: 60,
                    child: Center(
                      child: Text(
                        '99',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          ClipOval(
                            child: Container(
                              color: Colors.green,
                              height: 40,
                              width: 40,
                              child: Center(
                                child: Text(
                                  '0',
                                  style: TextStyle(color: Colors.white, fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          Text('Correct'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ClipOval(
                            child: Container(
                              color: Colors.black,
                              height: 40,
                              width: 40,
                              child: Center(
                                child: Text(
                                  '0',
                                  style: TextStyle(color: Colors.white, fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          Text('Attempted'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: <Widget>[
                    ClipOval(
                      child: Container(
                        color: Colors.grey,
                        height: 40,
                        width: 40,
                        child: Center(
                          child: Text(
                            '0',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Text('Remaining'),
                  ],
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
