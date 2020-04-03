import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:oneword/src/state/user.dart';

class Home extends StatelessWidget {
  static const route = '/home';

  Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user.toString());

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(
                'Karma: ${user.karma}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),
              ),
          ))
        ],
      ),
      body: Column(

      )
    );
  }
}
