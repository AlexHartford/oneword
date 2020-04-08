import 'package:flutter/material.dart';

import 'package:oneword/src/tabs/post/text.dart';

class PostButton extends StatelessWidget {
  PostButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: CircleBorder(),
      elevation: 1,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      child: Icon(Icons.create),
//      onPressed: () => showModalBottomSheet(context: context, builder: (_) => PostMenu())
      onPressed: () => Navigator.pushNamed(context, TextPost.route)
    );
  }
}
