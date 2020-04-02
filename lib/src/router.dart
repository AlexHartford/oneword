import 'package:flutter/material.dart';
import 'package:oneword/src/home.dart';
import 'package:oneword/src/landing.dart';
import 'package:oneword/src/tos.dart';

class Router {
  Route<Route> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Landing.route:
        return MaterialPageRoute(builder: (_) => Landing());
      case Tos.route:
        return MaterialPageRoute(builder: (_) => Tos(settings.arguments));
      default:
        // TODO: Log this in some more meaningful way
        print('\n\n*****\nBAD ROUTE\n*****\n\n');
        return MaterialPageRoute(builder: (_) => Home());
    }
  }
}