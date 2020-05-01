import 'package:flutter/material.dart';
import 'package:oneword/app_text.dart';
import 'package:oneword/src/state/preferences.dart';
import 'package:oneword/src/state/user.dart';

import 'package:oneword/src/tabs/account/finalize/view.dart';
import 'package:provider/provider.dart';

class FinalizeBanner extends StatelessWidget {
  FinalizeBanner({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserState>(context);
    _onPressed() => Navigator.pushNamed(context, Finalize.route);

    _showSnackBar() {
      user.prefs.setFlag(PrefKey.HIDE_ACCOUNT_SECURITY_BANNER, true);
      Navigator.pop(context);
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Done. You can access recovery settings here.'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () => user.prefs.setFlag(PrefKey.HIDE_ACCOUNT_SECURITY_BANNER, false)
          ),
        )
      );
    }

    _showDialog() => showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Account Security'),
          content: SECURE_ACCOUNT_DIALOG_TEXT,
          actions: [
            FlatButton(
                child: Text('DON\'T SHOW AGAIN'),
                textColor: Colors.grey,
                onPressed: _showSnackBar
            ),
            FlatButton(
              child: Text('GOT IT'),
              textColor: Colors.blue,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        )
      );

    return MaterialBanner(
      content: SECURE_ACCOUNT_BANNER_TEXT,
      leading: Icon(Icons.lock),
      contentTextStyle: TextStyle(color: Colors.black, fontSize: 16),
      forceActionsBelow: true,
      actions: [
        FlatButton(
          child: Text('LEARN MORE'),
          textColor: Colors.blue,
          onPressed: _showDialog
        ),
        FlatButton(
          child: Text('SECURE ACCOUNT'),
          textColor: Colors.blue,
          onPressed: _onPressed
        ),
      ],
    );
  }
}
