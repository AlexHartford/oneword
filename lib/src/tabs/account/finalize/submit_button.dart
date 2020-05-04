import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final Function submit;
  final bool loading;
  final String text;

  SubmitButton({Key key, @required this.submit, @required this.loading, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return loading == true
      ? Center(child: CircularProgressIndicator())
      : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: RaisedButton(
            child: Text(this.text),
            onPressed: submit
          ),
        );
  }
}
