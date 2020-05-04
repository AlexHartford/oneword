import 'package:flutter/material.dart';

class ChangePassword extends StatelessWidget {
  static const route = '/password';

  ChangePassword({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Change Password'),
        ),
        body: Center(
            child: Text('Change Password')
        )
    );
  }
}