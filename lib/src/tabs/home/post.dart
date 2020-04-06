import 'package:flutter/material.dart';

import 'package:oneword/src/tabs/home/buttons.dart';
import 'package:oneword/src/tabs/home/content.dart';

class Post extends StatelessWidget {
  Post({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Card(
        margin: const EdgeInsets.all(0),
        shape: Border(),
        child: Column(
          children: <Widget>[
            Content(),
            Buttons()
          ],
        ),
      ),
    );
  }
}
