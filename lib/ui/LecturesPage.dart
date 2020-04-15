import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class LecturesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lectures'),
      ),
      body: Scrollbar(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 8),
          children: <Widget>[
            for (int i = 0; i < 10; i++) LectureTile(i, titles[i], urls[i])
          ],
        ),
      ),
    );
  }
}

class LectureTile extends StatelessWidget {
  final int i;
  final String title;
  final String url;

  const LectureTile(this.i, this.title, this.url);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (await canLaunch(url)){
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      },
      child: ListTile(
        leading: ExcludeSemantics(
          child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.asset('assets/lectures/${i + 1}.jpg')),
        ),
        title: Text('Topic ${i + 1}'),
        subtitle: Text(titles[i]),
      ),
    );
  }
}

var titles = [
  'Exploratory data analysis with Pandas',
  'Visual Data Analysis with Python',
  'Classification, Decision Trees and k Nearest Neighbors',
  'Linear Classification and Regression',
  'Ensembles of algorithms and random forest.',
  'Feature engineering and feature selection',
  'Unsupervised learning',
  'Vowpal Wabbit: Learning with Gigabytes of Data',
  'Time series analysis in Python.',
  'Gradient boosting',
];

var urls = [
  'https://mlcourse.ai/articles/topic1-exploratory-data-analysis-with-pandas/',
  'https://mlcourse.ai/articles/topic2-visual-data-analysis-in-python/',
  'https://mlcourse.ai/articles/topic3-dt-knn/',
  'https://mlcourse.ai/articles/topic4-part1-linreg/',
  'https://mlcourse.ai/articles/topic5-part1-bagging/',
  'https://mlcourse.ai/articles/topic6-features/',
  'https://mlcourse.ai/articles/topic7-unsupervised/',
  'https://mlcourse.ai/articles/topic8-sgd-vw/',
  'https://mlcourse.ai/articles/topic9-part1-time-series/',
  'https://mlcourse.ai/articles/topic10-boosting/',
];
