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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(this.name),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.more_vert
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                controller: this._controller,
                shrinkWrap: true,
                reverse: true,
                itemBuilder: (context, index) => Message(
                    self: index.isEven,
                    message: '${index.toString()}: Test text ${index % 3 == 0 ? 'longer longer longer' : ''} message.  Tiger King Tiger King',
                    time: '${DateTime.now().toLocal().hour.toString()}: ${DateTime.now().toLocal().minute}'
                ),
                itemCount: 20,
              ),
            ),
            Align(alignment: Alignment.bottomCenter, child: Input())
          ],
        ),
      )
    );
  }
}
