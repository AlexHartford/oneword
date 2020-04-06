import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:oneword/src/state/user.dart';

import 'package:oneword/src/tabs/home/post.dart';

class Home extends StatelessWidget {
  static const route = '/home';

  Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Nearby'),
        centerTitle: true,
        actions: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Row(
                children: <Widget>[
                  Icon(FontAwesomeIcons.bolt),
                  Text(
                    '${user.karma}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    ),
                  ),
                ],
              ),
          ))
        ],
      ),
      body: ListView(
        children: <Widget>[
          Post(),
          Post(),
          Post(),
          Post(),
          Post(),
          Post()
        ],
      )
    );
  }
}
