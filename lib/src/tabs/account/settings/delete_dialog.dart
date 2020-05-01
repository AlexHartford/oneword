import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import 'package:oneword/app_text.dart';

import 'package:oneword/src/state/user.dart';

// TODO: Ask why the user is deleting their account after
class DeleteDialog extends HookWidget {
  DeleteDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserState>(context);

    final _checked = useState(false);

    _delete() async {
      // TODO: Reset nav state and prompt for survey
      Navigator.pop(context);
      await user.delete();
    }

    return AlertDialog(
      title: Text('Delete Account'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DELETE_ACCOUNT_DIALOG_TEXT,
          CheckboxListTile(
            title: Text('I understand what I am about to do.'),
            controlAffinity: ListTileControlAffinity.leading,
            value: _checked.value,
            activeColor: Colors.red,
            onChanged: (value) => _checked.value = value,
          )
        ],
      ),
      actions: [
        FlatButton(
            child: Text('NEVERMIND'),
            textColor: Colors.blue,
            onPressed: () => Navigator.pop(context)
        ),
        FlatButton(
          child: Text('DELETE PERMANENTLY'),
          textColor: Colors.red,
          onPressed: _checked.value ? _delete : null,
        ),
      ],
    );
  }
}
