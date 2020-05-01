import 'package:flutter/material.dart';
import 'package:oneword/src/tabs/account/settings_button.dart';
import 'package:provider/provider.dart';

import 'package:oneword/src/state/user.dart';

import 'package:oneword/src/tabs/account/header.dart';
import 'package:oneword/src/tabs/account/finalize_banner.dart';

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
          actions: [
            SettingsButton()
          ],
          flexibleSpace: Header(),
        ),
      ),
      body: ListView(
        children: [
          if (user.isLinked) FinalizeBanner()
        ]
      )
    );
  }
}
