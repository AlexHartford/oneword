import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  static const route = '/splash';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Splash')),
      backgroundColor: Colors.blueAccent,
    );
  }
}
