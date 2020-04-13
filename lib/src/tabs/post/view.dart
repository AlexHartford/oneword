import 'package:flutter/material.dart';

import 'package:oneword/src/tabs/post/text.dart';

class PostMenu extends StatelessWidget {
  PostMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => Navigator.popAndPushNamed(context, TextPost.route),
              )
            ],
          ),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          )
        ],
      )
    );
  }
}
