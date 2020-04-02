import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:oneword/src/state/user.dart';
import 'package:oneword/src/landing.dart';

void main() {
  runApp(App());
}

String getUniqueId() {
  return '123';
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => User(getUniqueId())),
      ],
      child: MaterialApp(
        title: 'oneword',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.blueAccent
        ),
        home: Landing()
      )
    );
  }
}
