import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  Message({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Message'),
        )
    );
  }
}
