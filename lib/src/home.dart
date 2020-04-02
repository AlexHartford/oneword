import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:oneword/src/state/user.dart';

class Home extends StatelessWidget {
  static const route = '/home';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text('oneword'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(user.toString()),
          ],
        )
      ),
    );
  }
}
