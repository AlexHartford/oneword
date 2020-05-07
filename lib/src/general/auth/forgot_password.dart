import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:oneword/src/general/auth/email_field.dart';
import 'package:oneword/src/general/auth/submit_button.dart';
import 'package:oneword/src/state/user.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends HookWidget {
  static const route = '/forgotpassword';

  ForgotPassword({Key key}) : super(key: key);

  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserState>(context);

    final _emailController = useTextEditingController();
    final _loading = useState(false);

    _onSubmit() async {
      if (_emailController.text.isEmpty) return;
      _loading.value = true;
      await user.forgotPassword(_emailController.text);
      _loading.value = false;
      _key.currentState.showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Instructions have been sent if an account exists with this email.'),
        )
      );
    }

    return Scaffold(
      key: _key,
      appBar: AppBar(title: Text('Forgot Password')),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Text(
            'Enter your email to receive password reset instructions.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16
            ),
          ),
          SizedBox(height: 8),
          EmailField(controller: _emailController),
          SubmitButton(submit: _onSubmit, text: 'SEND INSTRUCTIONS', loading: _loading.value)
        ],
      ),
    );
  }
}
