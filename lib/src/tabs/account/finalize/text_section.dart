import 'package:flutter/material.dart';
import 'package:oneword/app_text.dart';

class TextSection extends StatelessWidget {
  TextSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SECURE_ACCOUNT_DIALOG_TEXT,
    );
  }
}