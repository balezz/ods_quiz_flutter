import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import '../model/Quest.dart';
import 'package:odsquiz/DBProvider.dart';


class HomePage extends StatelessWidget {

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
              FooterCard()
            ],
          ),
        ),
      ),
    );
  }
}


class TopCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TopCardState();
  }
}

class _TopCardState extends State<TopCard> {
  List<Question> _quests = [];
  int _total;
  int _correct;
  int _attempted;
  int _remained;


  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    var _tmp = <Question>[];
    if (_quests.isEmpty) {
      _tmp = await DBProvider.dbp.getQuestions(context);
    }
    setState(() {
      _quests = _tmp;
      _total = _quests.length;
    });
  }

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

class CenterCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(

      child: Container(
        height: 320,
        child: GridView.count(
          childAspectRatio: 1.33,
          crossAxisCount: 2,
          children: <Widget>[
            Container(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/lectures');
                  },
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/icons/classroom.png',
                            height: 72,
                          ),
                        ),
                        Center(
                            child: Text(
                              'Lectures',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .subhead,
                            ))
                      ]),
                )),

            Container(
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/flashcards');
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/icons/brain.png',
                        height: 72,
                      ),
                    ),
                    Center(
                        child: Text(
                          'Flash Cards',
                          style: Theme
                              .of(context)
                              .textTheme
                              .subhead,
                        ))
                  ],
                ),
              ),
            ),
            Container(
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/training');
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/icons/training.png',
                        height: 72,
                      ),
                    ),
                    Center(
                        child: Text(
                          'Training',
                          style: Theme
                              .of(context)
                              .textTheme
                              .subhead,
                        ))
                  ],
                ),
              ),
            ),
            Container(
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/examine');
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/icons/examine.png',
                        height: 72,
                      ),
                    ),
                    Center(
                        child: Text(
                          'Examine',
                          style: Theme
                              .of(context)
                              .textTheme
                              .subhead,
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class FooterCard extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>print('more tapped'),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
              child: Text('More', style: TextStyle(color: Colors.blue, fontSize: 20),)
          ),
        ),
      ),
    );
  }

}
