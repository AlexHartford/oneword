import 'package:flutter/material.dart';

class TextDivider extends StatelessWidget {
  final String text;

  TextDivider({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: Colors.transparent,
            height: 36.0,
          ),
        ),
        Text(this.text),
        Expanded(
          child: Divider(
            color: Colors.transparent,
            height: 36.0,
          ),
        )
      ],
    );
  }
}