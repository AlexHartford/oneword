import 'package:flutter/material.dart';

import 'package:oneword/src/tabs/home/buttons.dart';
import 'package:oneword/src/tabs/home/content.dart';

class Post extends StatelessWidget {
  final String username, time, content;

  Post({Key key, this.username, this.time, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Card(
        margin: const EdgeInsets.all(0),
        elevation: 2.5,
        shape: Border(),
        child: Column(
          children: <Widget>[
            Content(
              username: this.username,
              time: this.time,
              content: this.content
            ),
            Buttons()
          ],
        ),
      ),
    );
  }
}
