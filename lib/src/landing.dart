import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:oneword/src/state/user.dart';

import 'package:oneword/src/welcome/view.dart';
import 'package:oneword/src/view.dart';
import 'package:oneword/src/splash.dart';
import 'package:oneword/src/deleted.dart';

class Landing extends StatelessWidget {
  static const route = '/';

  Widget redirect(context, UserState user, _) {
    switch (user.status) {
      case Status.Authenticated:
        return View();
      case Status.New:
        return Welcome();
      case Status.Error:
        return Welcome();
      case Status.Uninitialized:
        return Splash();
      case Status.Deleted:
        return Deleted();
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