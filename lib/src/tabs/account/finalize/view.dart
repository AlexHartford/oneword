import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:oneword/app_text.dart';
import 'package:oneword/src/tabs/account/finalize/text_section.dart';
import 'package:provider/provider.dart';

import 'package:oneword/src/general/auth/submit_button.dart';
import 'package:oneword/src/general/auth/password_field.dart';
import 'package:oneword/src/general/auth/email_field.dart';

import 'package:oneword/src/state/user.dart';

class Finalize extends HookWidget {
  static const route = '/finalize';

  Finalize({Key key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserState>(context);

    final _emailController = useTextEditingController();
    final _passwordController = useTextEditingController();

    final loading = useState(false);

    _convert() async {
      if (!_formKey.currentState.validate()) return;
      loading.value = true;
      bool success = await user.convert(_emailController.text, _passwordController.text);
      loading.value = false;
      success
        ? _key.currentState.showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text('Successfully finalized your account!'),
          )
        )
        : _key.currentState.showSnackBar(SnackBar(
          action: SnackBarAction(
            label: 'RETRY',
            onPressed: () => _convert()
          ),
          behavior: SnackBarBehavior.floating,
          content: Text('Please try again later.'),
        )
      );
      if (success) Navigator.pop(context);
    }

    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text('Finalize Account'),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: ListView(
            shrinkWrap: false,
            children: <Widget>[
              TextSection(text: SECURE_ACCOUNT_DIALOG_TEXT),
              EmailField(controller: _emailController),
              PasswordField(controller: _passwordController),
              SubmitButton(submit: _convert, loading: loading.value, text: 'Finalize')
            ],
          ),
        ),
      ),
    );
  }
}
