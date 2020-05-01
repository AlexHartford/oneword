import 'package:flutter/material.dart';

import 'package:oneword/src/tabs/account/settings.dart';

class SettingsButton extends StatelessWidget {
  SettingsButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.settings),
      onPressed: () => Navigator.pushNamed(context, Settings.route)
    );
  }
}
