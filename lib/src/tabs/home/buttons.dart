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
        InkWell(
          child: const Icon(
            Icons.arrow_upward,
            color: Colors.grey
          ),
          onTap: () {}
        ),
        Text('69'),
        InkWell(
          child: const Icon(
            Icons.arrow_downward,
            color: Colors.grey
          ),
          onTap: () {},
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
          SizedBox(width: 5),
          const Text('420')
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