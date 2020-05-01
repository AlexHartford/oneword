import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import 'package:oneword/src/tabs/account/finalize/submit_button.dart';
import 'package:oneword/src/tabs/account/finalize/password.dart';
import 'package:oneword/src/tabs/account/finalize/username.dart';

import 'package:oneword/src/state/user.dart';

class Finalize extends HookWidget {
  static const route = '/finalize';

  Finalize({Key key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserState>(context);

    final _usernameController = useTextEditingController();
    final _passwordController = useTextEditingController();

    final loading = useState(false);

    _convert() async {
      if (!_formKey.currentState.validate()) return;
      loading.value = true;
      bool success = await user.convert(_usernameController.text, _passwordController.text);
      loading.value = false;
      success
        ? _key.currentState.showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.all_inclusive),
                SizedBox(width: 8),
                Text('Successfully finalized your account!'),
              ],
            ),
          )
        )
        : _key.currentState.showSnackBar(SnackBar(
          action: SnackBarAction(
            label: 'RETRY',
            onPressed: () => _convert()
          ),
          behavior: SnackBarBehavior.floating,
          content: Row(
            children: <Widget>[
              Icon(Icons.cloud_off),
              SizedBox(width: 8),
              Text('Please try again later.'),
            ],
          ),
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
              UsernameField(controller: _usernameController, checkUsername: user.checkUsername),
              PasswordField(controller: _passwordController),
              SubmitButton(convert: _convert, loading: loading.value)
            ],
          ),
        ),
      ),
    );
  }
}
