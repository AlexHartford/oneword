import 'package:flutter/material.dart';

class Timer extends StatelessWidget {
  Timer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Icon(Icons.pie_chart),
        SizedBox(width: 4),
        Text('20 hrs')
      ]
    );
  }
}
