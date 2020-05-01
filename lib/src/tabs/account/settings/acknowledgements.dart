import 'package:flutter/material.dart';

class Acknowledgements extends StatelessWidget {
  static const route = '/acknowledgements';

  Acknowledgements({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acknowledgements'),
      ),
      body: Card(margin: const EdgeInsets.all(0), shape: Border(), child: AboutListTile()));
  }
}