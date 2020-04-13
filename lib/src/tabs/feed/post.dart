import 'package:flutter/material.dart';

import 'package:oneword/src/state/post.dart';

import 'package:oneword/src/tabs/feed/buttons.dart';
import 'package:oneword/src/tabs/feed/content.dart';

class Post extends StatelessWidget {
  final PostModel post;

  Post({Key key, this.post}) : super(key: key);

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
              username: this.post.username,
              time: this.post.time,
              content: this.post.content
            ),
            Buttons(
              post: this.post,
            )
          ],
        ),
      ),
    );
  }
}
