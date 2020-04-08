import 'package:flutter/material.dart';

import 'package:oneword/src/tabs/home/kebab.dart';

class Content extends StatelessWidget {
  final String username, time, content;

  Content({Key key, this.username, this.time, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(
          '$username · $time',
          style: TextStyle(
              color: Colors.grey,
              fontSize: 14
          ),
        ),
        subtitle: Text(
          content,
          style: TextStyle(
              color: Colors.black,
              fontSize: 16
          ),
        ),
        trailing: Kebab()
    );
  }
}