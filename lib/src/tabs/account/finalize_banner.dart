import 'package:flutter/material.dart';
import 'package:oneword/app_text.dart';

import 'package:oneword/src/tabs/account/finalize/view.dart';

class FinalizeBanner extends StatelessWidget {
  final Type type;

  FinalizeBanner({Key key, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _onPressed() => Navigator.pushNamed(context, Finalize.route);

    _showDialog() => showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Account Security'),
          content: SECURE_ACCOUNT_DIALOG_TEXT,
          actions: [
            FlatButton(
                child: Text('DON\'T SHOW AGAIN'),
                onPressed: () => Navigator.pop(context)),
            FlatButton(
              child: Text('GOT IT'),
              onPressed: _onPressed,
            ),
          ],
        )
      );

    return MaterialBanner(
      content: SECURE_ACCOUNT_BANNER_TEXT,
      leading: Icon(Icons.warning),
      contentTextStyle: TextStyle(color: Colors.black, fontSize: 16),
      forceActionsBelow: true,
      actions: [
        FlatButton(child: Text('LEARN MORE'), onPressed: _showDialog),
        FlatButton(
          child: Text('SECURE ACCOUNT'),
          onPressed: _onPressed,
        ),
      ],
    );
  }
}
