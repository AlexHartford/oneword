import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:oneword/src/state/user.dart';

class Header extends StatelessWidget {
  Header({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user =  Provider.of<UserState>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 64),
        CircleAvatar(
          radius: 52,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            backgroundImage: user.getDefaultAvatar().image,
          ),
        ),
        SizedBox(height: 16),
        Text(
          user.name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16
          ),
        )
      ],
    );
  }
}
