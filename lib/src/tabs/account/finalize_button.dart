import 'package:flutter/material.dart';
import 'package:oneword/src/tabs/account/finalize/view.dart';

enum Type { Icon, Text }

class FinalizeButton extends StatelessWidget {
  final Type type;

  FinalizeButton({Key key, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    _onPressed() => Navigator.pushNamed(context, Finalize.route);

    return type == Type.Icon
        ? IconButton(
            icon: Icon(Icons.warning),
            color: Colors.red,
            onPressed: _onPressed,
          )
        : RaisedButton(
            child: Text('Secure your account now to make it recoverable'),
            color: Colors.red,
            onPressed: _onPressed,
          );
  }
}
