import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  Post({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Post'),
        )
    );
  }
}
