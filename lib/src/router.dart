import 'package:flutter/material.dart';
import 'package:oneword/src/tabs/account/finalize/view.dart';
import 'package:oneword/src/tabs/account/settings/acknowledgements.dart';
import 'package:oneword/src/tabs/account/settings/view.dart';
import 'package:oneword/src/tabs/feed/view.dart';
import 'package:oneword/src/landing.dart';
import 'package:oneword/src/tabs/post/text.dart';
import 'package:oneword/src/tos.dart';

class Router {
  Route<Route> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Landing.route:
        return MaterialPageRoute(builder: (_) => Landing());
      case Tos.route:
        return MaterialPageRoute(builder: (_) => Tos(settings.arguments));
      case TextPost.route:
        return MaterialPageRoute(builder: (_) => TextPost());
      case Finalize.route:
        return MaterialPageRoute(builder: (_) => Finalize());
      case Settings.route:
        return MaterialPageRoute(builder: (_) => Settings());
      case Acknowledgements.route:
        return MaterialPageRoute(builder: (_) => Acknowledgements());
      default:
        // TODO: Log this in some more meaningful way
        print('\n\n*****\nBAD ROUTE\n*****\n\n');
        return MaterialPageRoute(builder: (_) => Feed());
    }
  }
}