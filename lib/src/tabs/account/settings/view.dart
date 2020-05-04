import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oneword/src/general/list_card.dart';
import 'package:oneword/src/tabs/account/finalize/view.dart';
import 'package:oneword/src/tabs/account/settings/acknowledgements.dart';
import 'package:oneword/src/tabs/account/settings/change_password.dart';
import 'package:oneword/src/tabs/account/settings/delete_dialog.dart';
import 'package:oneword/src/tabs/account/settings/security_questions.dart';
import 'package:provider/provider.dart';

import 'package:oneword/src/state/user.dart';

import 'package:oneword/src/general/text_divider.dart';
import 'package:oneword/src/tos.dart';
import 'package:oneword/src/welcome/view.dart';

class Settings extends StatelessWidget {
  static const route = '/ListCards';

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
      appBar: AppBar(title: Text('ListCards')),
      body: ListView(
        children: [
          TextDivider(text: 'General', align: TextAlign.Left),
          ListCard(icon: Icons.location_searching, title: 'Reset Locations'),
          ListCard(
            icon: Icons.bug_report,
            title: 'Report Bug',
            trailing: Icon(Icons.arrow_forward)
          ),
          TextDivider(text: 'Account', align: TextAlign.Left),
          if (!secured) ListCard(
            icon: Icons.priority_high,
            title: 'Enable Recovery',
            subtext: 'So you don\'t lose access to your account',
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.pushNamed(context, Finalize.route),
          ),
          if (secured) ListCard(
            icon: Icons.person,
            title: 'Username',
            subtext: user.username
          ),
          if (secured) ListCard(
            icon: Icons.update,
            title: 'Change Password',
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.pushNamed(context, ChangePassword.route)
          ),
          if (secured) ListCard(
            icon: Icons.question_answer,
            title: 'Security Questions',
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.pushNamed(context, SecurityQuestions.route)
          ),
          TextDivider(text: 'About', align: TextAlign.Left),
          ListCard(
            icon: Icons.toc,
            title: 'Terms of Service',
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.pushNamed(context, Tos.route, arguments: Tabs.ToS.index)
          ),
          ListCard(
            icon: Icons.toc,
            title: 'Privacy Policy',
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.pushNamed(context, Tos.route, arguments: Tabs.PP.index)
          ),
          ListCard(
            icon: FontAwesomeIcons.trophy,
            title: 'Acknowledgements',
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.pushNamed(context, Acknowledgements.route)
          ),
          TextDivider(text: 'Danger Zone', align: TextAlign.Left),
          ListCard(icon: Icons.warning, title: 'Delete Account', onTap: _showDeleteDialog)
        ],
      )
    );
  }
}