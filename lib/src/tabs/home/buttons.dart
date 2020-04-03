import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      children: <Widget>[
        Votes(),
        Comment(),
        Share()
      ],
    );
  }
}

class Votes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        FlatButton(
          child: const Icon(Icons.arrow_upward),
          onPressed: () {},
        ),
        Text('69'),
        FlatButton(
          child: const Icon(Icons.arrow_downward),
          onPressed: () {},
        ),
      ],
    );
  }
}

class Comment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Row(
        children: <Widget>[
          const Icon(Icons.comment),
          const Text(' 420')
        ],
      ),
      onPressed: () {},
    );
  }
}

class Share extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: const Icon(Icons.share),
      onPressed: () {},
    );
  }
}