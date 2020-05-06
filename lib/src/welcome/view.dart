import 'package:flutter/material.dart';
import 'package:oneword/src/welcome/create_email.dart';
import 'package:provider/provider.dart';

import 'package:oneword/src/state/user.dart';
import 'package:oneword/src/tos.dart';

enum Tabs { ToS, PP }

class Welcome extends StatelessWidget {
  static const route = '/welcome';

  Welcome({Key key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserState>(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                RaisedButton(
                  onPressed: () => showModalBottomSheet(
                    context: context,
                    builder: (_) => CreateEmail(formKey: _formKey),
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(25.0)
                      )
                    ),
                  ),
                  child: Text('Create account'),
                ),
                OutlineButton(
                  onPressed: () => user.create(),
                  child: Text('Continue as guest'),
                ),
                Text(
                  'By proceeding you agree to the\nTerms of Service and Privacy Policy',
                  textAlign: TextAlign.center,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: OutlineButton(
                        onPressed: () => Navigator.pushNamed(context, Tos.route, arguments: Tabs.ToS.index),
                        child: Text('Terms of Service'),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: OutlineButton(
                        onPressed: () => Navigator.pushNamed(context, Tos.route, arguments: Tabs.PP.index),
                        child: Text('Privacy Policy'),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
