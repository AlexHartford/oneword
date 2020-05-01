import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oneword/src/tabs/account/finalize/view.dart';
import 'package:oneword/src/tabs/account/settings/acknowledgements.dart';
import 'package:oneword/src/tabs/account/settings/delete_dialog.dart';
import 'package:provider/provider.dart';

import 'package:oneword/src/state/user.dart';

import 'package:oneword/src/general/text_divider.dart';
import 'package:oneword/src/tos.dart';
import 'package:oneword/src/welcome/view.dart';

class Settings extends StatelessWidget {
  static const route = '/settings';

  Settings({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserState>(context);

    final bool secured = user.isLinked;

    _showDeleteDialog() => showDialog(
        context: context,
        builder: (_) => DeleteDialog()
    );

    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView(
        children: [
          TextDivider(text: 'General', align: TextAlign.Left),
          Setting(icon: Icons.location_searching, setting: 'Reset Locations'),
          Setting(
            icon: Icons.bug_report,
            setting: 'Report Bug',
            trailing: Icon(Icons.arrow_forward)
          ),
          TextDivider(text: 'Account', align: TextAlign.Left),
          if (!secured) Setting(
                icon: Icons.priority_high,
                setting: 'Enable Recovery',
                subtext: 'So you don\'t lose access to your account',
                trailing: Icon(Icons.arrow_forward),
                onTap: () => Navigator.pushNamed(context, Finalize.route),
            ),
          if (secured) Setting(
            icon: Icons.person,
            setting: 'Username',
            subtext: user.username),
          if (secured) Setting(
            icon: Icons.update,
            setting: 'Change Password',
            trailing: Icon(Icons.arrow_forward)
          ),
          if (secured) Setting(
            icon: Icons.question_answer,
            setting: 'Security Questions',
            trailing: Icon(Icons.arrow_forward)
          ),
          TextDivider(text: 'About', align: TextAlign.Left),
          Setting(
            icon: Icons.toc,
            setting: 'Terms of Service',
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.pushNamed(context, Tos.route, arguments: Tabs.ToS.index)
          ),
          Setting(
            icon: Icons.toc,
            setting: 'Privacy Policy',
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.pushNamed(context, Tos.route, arguments: Tabs.PP.index)
          ),
          Setting(
            icon: FontAwesomeIcons.trophy,
            setting: 'Acknowledgements',
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.pushNamed(context, Acknowledgements.route)
          ),
          TextDivider(text: 'Danger Zone', align: TextAlign.Left),
          Setting(icon: Icons.warning, setting: 'Delete Account', onTap: _showDeleteDialog)
        ],
      )
    );
  }
}

class Setting extends StatelessWidget {
  final IconData icon;
  final String setting;
  final String subtext;
  final Widget trailing;
  final onTap;

  Setting(
      {Key key,
      @required this.icon,
      @required this.setting,
      this.subtext,
      this.trailing,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      shape: Border(),
      child: InkWell(
        onTap: this.onTap,
        child: ListTile(
          title: Text(this.setting),
          leading: Icon(icon),
          trailing: this.trailing,
          subtitle: this.subtext != null ? Text(this.subtext) : null,
        ),
      )
    );
  }
}
