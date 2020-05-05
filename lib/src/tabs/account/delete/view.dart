import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:oneword/app_text.dart';
import 'package:oneword/src/tabs/account/finalize/text_section.dart';
import 'package:provider/provider.dart';

import 'package:oneword/src/tabs/account/finalize/submit_button.dart';
import 'package:oneword/src/tabs/account/finalize/password.dart';

import 'package:oneword/src/state/user.dart';

import 'package:oneword/src/tabs/account/delete/delete_dialog.dart';

class DeleteAccount extends HookWidget {
  static const route = '/delete';

  DeleteAccount({Key key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserState>(context);

    final _passwordController = useTextEditingController();

    final loading = useState(false);

    _showDeleteDialog() => showDialog(
        context: context,
        builder: (_) => DeleteDialog()
    );

    _delete() async {
      if (!_formKey.currentState.validate()) return;
      loading.value = true;
      bool success = await user.reAuthenticate(_passwordController.text);
      loading.value = false;
      if (!success) _key.currentState.showSnackBar(
        SnackBar(
          action: SnackBarAction(
            label: 'FORGOT PASSWORD',
            // TODO: IMPLEMENT FORGOT PASSWORD FLOW
            onPressed: () => print('TODO: MAKE THIS DO SOMETHING')
          ),
          behavior: SnackBarBehavior.floating,
          content: Text('Failed to authenticate.'),
        )
      );
      if (success) {
        _showDeleteDialog();
      }
    }

    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text('Delete Account'),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: ListView(
            shrinkWrap: false,
            children: <Widget>[
              TextSection(text: DELETE_ACCOUNT_TEXT),
              PasswordField(controller: _passwordController),
              SubmitButton(submit: _delete, loading: loading.value, text: 'Delete Account Forever')
            ],
          ),
        ),
      ),
    );
  }
}
