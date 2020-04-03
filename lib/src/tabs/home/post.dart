import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:oneword/src/tabs/home/buttons.dart';
import 'package:oneword/src/tabs/home/content.dart';
import 'package:oneword/src/tabs/home/kebab.dart';

class Post extends StatelessWidget {
  Post({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 1.0),
      child: Card(
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
