import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:oneword/src/state/user.dart';
import 'package:oneword/src/landing.dart';

void main() async {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => User.instance),
      ],
      child: MaterialApp(
        title: 'oneword',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.blueAccent,
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.blue,
            textTheme: ButtonTextTheme.primary
          )
        ),
        home: Landing()
      )
    );
  }
}