import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:oneword/app_text.dart';
import 'package:oneword/src/tabs/account/finalize/text_section.dart';
import 'package:provider/provider.dart';

import 'package:oneword/src/tabs/account/finalize/submit_button.dart';
import 'package:oneword/src/tabs/account/finalize/password.dart';

import 'package:oneword/src/state/user.dart';

class ChangePassword extends HookWidget {
  static const route = '/password';

  ChangePassword({Key key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserState>(context);

    final _currentPasswordController = useTextEditingController();
    final _passwordController = useTextEditingController();

    final loading = useState(false);

    _submit() async {
      if (!_formKey.currentState.validate()) return;
      loading.value = true;
      Map<bool, String> success = await user.changePassword(_currentPasswordController.text, _passwordController.text);
      loading.value = false;
      success.containsKey(true)
        ? _key.currentState.showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(success[true])
          )
        )
        : _key.currentState.showSnackBar(
          SnackBar(
            action: SnackBarAction(
              label: 'FORGOT PASSWORD',
              // TODO: IMPLEMENT FORGOT PASSWORD FLOW
              onPressed: () => print('TODO: MAKE THIS DO SOMETHING')
            ),
            behavior: SnackBarBehavior.floating,
            content: Text(success[false])
          )
        );
      if (success.containsKey(true)) Navigator.pop(context);
    }

    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: ListView(
            shrinkWrap: false,
            children: <Widget>[
              TextSection(text: CHANGE_PASSWORD_TEXT),
              PasswordField(controller: _currentPasswordController, labelText: 'Current Password'),
              PasswordField(controller: _passwordController),
              SubmitButton(submit: _submit, loading: loading.value, text: 'Change Password')
            ],
          ),
        ),
      ),
    );
  }
}
