import 'package:flutter/material.dart';

class SecurityQuestions extends StatelessWidget {
  static const route = '/security';

  SecurityQuestions({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Security Questions'),
      ),
      body: Center(
        child: Text('Security Method TBD')
      )
    );
  }
}