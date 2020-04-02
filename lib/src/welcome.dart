import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  static const route = '/welcome';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Welcome')),
    );
  }
}
