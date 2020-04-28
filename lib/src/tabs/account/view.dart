import 'package:flutter/material.dart';
import 'package:oneword/src/tabs/account/conversion/view.dart';
import 'package:provider/provider.dart';

import 'package:oneword/src/state/user.dart';

class Account extends StatelessWidget {
  Account({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user =  Provider.of<UserState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
      ),
//      body: Center(child: Text(user.toString())),
      body: Convert(),
    );
  }
}
