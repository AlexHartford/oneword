import 'package:flutter/material.dart';

class TextSection extends StatelessWidget {
  final Widget text;

  TextSection({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: this.text,
    );
  }
}