import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  static const route = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('oneword'),
      ),
      body: Center(child: Text('Home')),
    );
  }
}
