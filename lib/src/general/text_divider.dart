import 'package:flutter/material.dart';

enum TextAlign { Left, Center }

class TextDivider extends StatelessWidget {
  final String text;
  final TextAlign align;

  TextDivider({Key key, @required this.text, @required this.align}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (this.align == TextAlign.Center) Expanded(
          child: Divider(
            color: Colors.transparent,
            height: 32.0,
          ),
        ),
        if (this.align == TextAlign.Left) SizedBox(width: 16),
        Text(
          this.text.toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12
          )
        ),
        Expanded(
          child: Divider(
            color: Colors.transparent,
            height: 32.0,
          ),
        )
      ],
    );
  }
}