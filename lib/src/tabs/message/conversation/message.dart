import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final bool self;

  Message({Key key, this.self = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Container(
          color: self ? Colors.blue.withOpacity(0.25) : Colors.grey.withOpacity(0.25),
          padding: EdgeInsets.all(8.0),
          child: Text('Hello darkness my old friend.  I\'ve come to talk with you again.'),
        )
      ],
    );
  }
}
