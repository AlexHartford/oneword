import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import 'package:oneword/src/tabs/account/conversion/convert_button.dart';
import 'package:oneword/src/tabs/account/conversion/password.dart';
import 'package:oneword/src/tabs/account/conversion/username.dart';

import 'package:oneword/src/state/user.dart';

class Convert extends HookWidget {
  Convert({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserState>(context);

    final _usernameController = useTextEditingController();
    final _passwordController = useTextEditingController();

    final loading = useState(false);

    // TODO: Validate form
    const validUsername = false;
    const validPassword = false;

    _convert() async {
      if (!(validUsername && validPassword)) return;
      loading.value = true;
      bool success = await user.convert(_usernameController.text, _passwordController.text);
      loading.value = false;
      if (success) {
        print('Success!');
      } else {
        print('Failed.');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Convert Account'),
      ),
      body: Form(
        child: Center(
          child: ListView(
            shrinkWrap: false,
            children: <Widget>[
              UsernameField(controller: _usernameController, checkUsername: user.checkUsername),
              PasswordField(controller: _passwordController),
              ConvertButton(convert: _convert, loading: loading.value)
            ],
          ),
        ),
      ),
    );
  }
}
