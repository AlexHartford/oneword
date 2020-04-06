import 'package:flutter/material.dart';

import 'package:oneword/src/tabs/message/conversation/input.dart';
import 'package:oneword/src/tabs/message/conversation/message.dart';

class Conversation extends StatelessWidget {
  final String name;

  Conversation({Key key, this.name}) : super(key: key);

  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.name),
      ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            controller: this._controller,
            shrinkWrap: true,
            reverse: true,
            itemBuilder: (context, index) => Message(self: index.isEven),
            itemCount: 20,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Input()
          )
        ],
      )
    );
  }
}
