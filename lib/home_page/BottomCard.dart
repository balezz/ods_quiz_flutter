import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BottomCard extends StatelessWidget{
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