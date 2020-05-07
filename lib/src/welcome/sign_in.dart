import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:oneword/src/general/auth/forgot_password.dart';
import 'package:provider/provider.dart';

import 'package:oneword/src/state/user.dart';

import 'package:oneword/src/general/auth/email_field.dart';
import 'package:oneword/src/general/auth/password_field.dart';
import 'package:oneword/src/general/auth/submit_button.dart';

class SignIn extends HookWidget {
  final formKey;

  SignIn({Key key, this.formKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserState>(context);

    final _loading = useState(false);
    final _failed = useState(false);

    final _emailController = useTextEditingController();
    final _passwordController = useTextEditingController();

    _onSubmit() async {
      if (!formKey.currentState.validate()) return;
      _loading.value = true;
      bool success = await user.signInWithEmail(
          _emailController.text,
          _passwordController.text
      );
      _loading.value = false;

      _failed.value = !success;

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
              'Welcome back!',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
              )
            ),
            EmailField(
              controller: _emailController,
              validator: (value) => value.isEmpty ? 'Please enter email' : null
            ),
            PasswordField(
              controller: _passwordController,
              validator: (value) => value.isEmpty ? 'Please enter password' : null
            ),
            SubmitButton(
                text: 'SIGN IN',
                loading: _loading.value,
                submit: _onSubmit
            ),
            if (_failed.value)
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: OutlineButton(
                  child: Text('FORGOT PASSWORD'),
                  onPressed: () => Navigator.popAndPushNamed(context, ForgotPassword.route),
                  ),
                ),
            SizedBox(height: 16)
          ],
        ),
      ),
    );
  }
}
