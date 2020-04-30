import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final Function convert;
  final bool loading;

  SubmitButton({Key key, this.convert, this.loading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return loading == true
      ? Center(child: CircularProgressIndicator())
      : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: RaisedButton(
            child: Text('Finalize'),
            onPressed: convert
          ),
        );
  }
}
