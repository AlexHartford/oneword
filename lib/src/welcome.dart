import 'package:flutter/material.dart';
import 'package:oneword/src/state/user.dart';
import 'package:provider/provider.dart';

class Welcome extends StatelessWidget {
  static const route = '/welcome';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      body: SafeArea(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Text(user.toString()),
                RaisedButton(
                  onPressed: () => user.create(),
                  child: Text('Join Now'),
                ),
                Text('You agree to our terms and conditions')
              ],
            ),
          )
        ),
      ),
    );
  }
}
