import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import 'package:oneword/src/state/user.dart';

import 'package:oneword/src/general/auth/email_field.dart';
import 'package:oneword/src/general/auth/password_field.dart';
import 'package:oneword/src/general/auth/submit_button.dart';

class CreateEmail extends HookWidget {
  final formKey;

  CreateEmail({Key key, this.formKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserState>(context);

    final _loading = useState(false);

    final _emailController = useTextEditingController();
    final _passwordController = useTextEditingController();

    _onSubmit() async {
      if (!formKey.currentState.validate()) return;
      _loading.value = true;
      bool success = await user.createWithEmail(
        _emailController.text,
        _passwordController.text
      );
      _loading.value = false;

      if (success) Navigator.pop(context);
    }

    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Form(
        key: formKey,
        child: ListView(
          shrinkWrap: true,
          children: [
            SizedBox(height: 16),
            Text(
              'Welcome to doe!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold
              )
            ),
            Text(
              'Your email is used for verification purposes only.\nIt will not be visible to anyone else.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16
              ),
            ),
            EmailField(controller: _emailController),
            PasswordField(controller: _passwordController),
            SubmitButton(
              text: 'CREATE ACCOUNT',
              loading: _loading.value,
              submit: _onSubmit
            ),
            SizedBox(height: 16)
          ],
        ),
      ),
    );
  }
}
