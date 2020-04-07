import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

import 'package:odsquiz/lecture_page/LecturesPage.dart';
import 'package:odsquiz/train_page/TrainPage.dart';
import 'package:odsquiz/flash_page/FlashPage.dart';

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
