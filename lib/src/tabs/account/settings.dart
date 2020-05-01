import 'package:flutter/material.dart';

import 'package:oneword/src/general/text_divider.dart';
import 'package:oneword/src/state/preferences.dart';

class Settings extends StatelessWidget {
  static const route = '/settings';

  Settings({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Preferences prefs = Preferences();

    _getPreferences() async {
      print(await prefs.map);
    }

    _getPreferences();

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings')
      ),
      body: ListView(
        children: [
          TextDivider(text: 'General', align: TextAlign.Left),
          Setting(icon: Icons.verified_user, setting: 'Verified'),
          Setting(icon: Icons.verified_user, setting: 'Verified', subtext: 'hello world'),
          Setting(icon: Icons.verified_user, setting: 'Verified'),
          TextDivider(text: 'Account', align: TextAlign.Left),
          Setting(icon: Icons.verified_user, setting: 'Verified'),
          Setting(icon: Icons.verified_user, setting: 'Verified'),
          Setting(icon: Icons.verified_user, setting: 'Verified'),
          TextDivider(text: 'About', align: TextAlign.Left),
          Setting(icon: Icons.verified_user, setting: 'Verified'),
          Setting(icon: Icons.verified_user, setting: 'Verified'),
          Setting(icon: Icons.verified_user, setting: 'Verified')
        ],
      ),
    );
  }
}

class Setting extends StatelessWidget {
  final IconData icon;
  final String setting;
  final String subtext;

  Setting({Key key, @required this.icon, @required this.setting, this.subtext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      shape: Border(),
        child: ListTile(
          title: Text(this.setting),
          leading: Icon(icon),
          trailing: Text('bar'),
          subtitle: this.subtext != null ? Text(this.subtext) : null,
        )
    );
  }
}
