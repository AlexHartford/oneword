import 'package:flutter/material.dart';
import 'package:oneword/src/tabs/account/finalize/view.dart';
import 'package:oneword/src/tabs/account/finalize_button.dart';
import 'package:oneword/src/tabs/account/header.dart';
import 'package:provider/provider.dart';

import 'package:oneword/src/state/user.dart';

class Account extends StatelessWidget {
  Account({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user =  Provider.of<UserState>(context);
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.33),
        child: AppBar(
          title: Text('Account'),
          centerTitle: true,
          actions: <Widget>[
            user.isLinked ? FinalizeButton(type: Type.Icon) : null
          ],
          flexibleSpace: Header(),
        ),
      ),
      body: ListView(
        children: [
          user.isLinked ? FinalizeButton(type: Type.Text) : null
//          Finalize()
        ]
      )
    );
  }
}
