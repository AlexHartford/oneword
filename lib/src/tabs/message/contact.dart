import 'package:flutter/material.dart';

import 'package:oneword/src/tabs/message/conversation/view.dart';
import 'package:oneword/src/tabs/message/timer.dart';

class Contact extends StatelessWidget {
  Contact({Key key}) : super(key: key);

  void openConversation(String name, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => Conversation(key: UniqueKey(), name: name)));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      shape: Border(),
      child: InkWell(
        onTap: () => this.openConversation('Sexual Harassment Panda', context),
        child: Flex(
          direction: Axis.horizontal,
          children: <Widget>[
            Flexible(
              child: ListTile(
                title: Text('Sexual Harassment Panda'),
                subtitle: Text(
                  'This text is long so it should get cut off after a certain amount of characters',
                  overflow: TextOverflow.ellipsis),
                trailing: Timer(),
              ),
            ),
          ]
        ),
      )
    );
  }
}
