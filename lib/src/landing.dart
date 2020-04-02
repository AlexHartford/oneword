import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:oneword/src/state/user.dart';

import 'package:oneword/src/home.dart';
import 'package:oneword/src/welcome.dart';
import 'package:oneword/src/splash.dart';

class Landing extends StatelessWidget {
  static const routeName = '/';

  Widget redirect(context, User user, _) {
    switch (user.status) {
      case Status.Authenticated:
        return Home();
      case Status.New:
        return Welcome();
      case Status.Error:
        // TODO: Handle error
      case Status.Uninitialized:
      case Status.Authenticating:
      default:
        return Splash();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: redirect);
  }
}