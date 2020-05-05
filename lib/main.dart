import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:oneword/src/style.dart';

import 'package:oneword/src/router.dart';

import 'package:oneword/src/state/user.dart';
import 'package:oneword/src/state/feed.dart';

import 'package:oneword/src/landing.dart';

void main() async {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserState.instance),
        ChangeNotifierProvider(create: (_) => FeedState()),
      ],
      child: MaterialApp(
        title: 'doe',
        theme: ThemeData(
          primarySwatch: black,
          accentColor: Colors.lightBlue,
//          scaffoldBackgroundColor: Colors.white70,
          buttonTheme: ButtonThemeData(
            buttonColor: black,
            textTheme: ButtonTextTheme.primary
          )
        ),
        onGenerateRoute: Router().generateRoute,
        home: Landing()
      )
    );
  }
}
