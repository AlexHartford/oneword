import 'package:flutter/material.dart';
import 'package:oneword/src/tabs/home/view.dart';
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
      default:
        // TODO: Log this in some more meaningful way
        print('\n\n*****\nBAD ROUTE\n*****\n\n');
        return MaterialPageRoute(builder: (_) => Home());
    }
  }
}