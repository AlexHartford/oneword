import 'package:flutter/material.dart';

import 'kebab.dart';

class Content extends StatelessWidget {
  Content({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(
          'username · 2 minutes ago',
          style: TextStyle(
              color: Colors.grey,
              fontSize: 14
          ),
        ),
        subtitle: Text(
          'something something shitpost you know that dude with the tigers something something that bitch carol baskin',
          style: TextStyle(
              color: Colors.black,
              fontSize: 16
          ),
        ),
        trailing: Kebab()
    );
  }
}