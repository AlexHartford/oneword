import 'package:flutter/material.dart';
import 'package:oneword/src/state/preferences.dart';
import 'package:oneword/src/tabs/account/settings_button.dart';
import 'package:oneword/src/tabs/account/stats.dart';
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

    Future<bool> _getPref() async {
      return await user.prefs.getFlag(PrefKey.HIDE_ACCOUNT_SECURITY_BANNER);
    }

    // TODO: Retrieve updated account stats / settings

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
      body: FutureBuilder(
        future: _getPref(),
        builder: (_, AsyncSnapshot snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              bool _hideBanner;
              if (snapshot.hasError) _hideBanner = false;
              else _hideBanner = snapshot.data ?? false;
              return ListView(
                shrinkWrap: true,
                children: [
                  if (!user.isLinked && !_hideBanner) FinalizeBanner(),
                  Stats()
                ]
              );
          }
        },
      ),
    );
  }
}
