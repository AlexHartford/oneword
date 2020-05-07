import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:oneword/src/state/user.dart';

import 'package:oneword/src/general/list_card.dart';
import 'package:oneword/src/tabs/account/delete/delete_dialog.dart';
import 'package:oneword/src/tabs/account/delete/view.dart';
import 'package:oneword/src/tabs/account/finalize/view.dart';
import 'package:oneword/src/tabs/account/settings/acknowledgements.dart';
import 'package:oneword/src/general/text_divider.dart';
import 'package:oneword/src/tos.dart';
import 'package:oneword/src/welcome/view.dart';

class Settings extends StatelessWidget {
  static const route = '/settings';

  Settings({Key key}) : super(key: key);

  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserState>(context);

    final bool secured = user.isLinked;

    _showDeleteDialog() => showDialog(
        context: context,
        builder: (_) => DeleteDialog()
    );

    _showForgotPasswordSnackBar(bool success) {
      String text = success
          ?
          'Password reset instructions have been sent to your email.'
          :
          'Failed to send password reset instructions. Please try again later.';
      _key.currentState.showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(text),
        )
      );
    }

    return Scaffold(
      key: _key,
      appBar: AppBar(title: Text('Settings')),
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
            title: 'Email',
            subtext: user.email
          ),
          if (secured) ListCard(
            icon: Icons.update,
            title: 'Reset Password',
            trailing: Icon(Icons.arrow_forward),
            onTap: () async =>
              _showForgotPasswordSnackBar(await user.forgotPassword(user.email))
          ),
          if (secured) ListCard(
            icon: Icons.input,
            title: 'Sign Out',
            trailing: Icon(Icons.arrow_forward),
            onTap: () { user.signOut(); Navigator.pop(context); }
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
          ListCard(
            icon: Icons.warning,
            title: 'Delete Account',
            trailing: secured ? Icon(Icons.arrow_forward) : null,
            onTap: () => secured ? Navigator.pushNamed(context, DeleteAccount.route) : _showDeleteDialog()
          )
        ],
      )
    );
  }
}