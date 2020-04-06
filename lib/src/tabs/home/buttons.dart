import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

enum Vote { up, down, none}

class Votes extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final vote = useState(Vote.none);
    final score = useState(69);

    handleVote(Vote type) {
      if (type == Vote.up) {
        if (vote.value == Vote.down) score.value++;
        vote.value == Vote.up ? score.value-- : score.value++;
        vote.value = vote.value == Vote.up ? Vote.none : Vote.up;
      }

      if (type == Vote.down) {
        if (vote.value == Vote.up) score.value--;
        vote.value == Vote.down ? score.value++ : score.value--;
        vote.value = vote.value == Vote.down ? Vote.none : Vote.down;
      }
    }

    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(
            FontAwesomeIcons.arrowAltCircleUp,
            color: vote.value == Vote.up ? Colors.blue : Colors.grey,
          ),
          onPressed: () => handleVote(Vote.up),
        ),
        Text(
          score.value.toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        IconButton(
          icon: Icon(
            FontAwesomeIcons.arrowAltCircleDown,
            color: vote.value == Vote.down ? Colors.blue : Colors.grey,
          ),
          onPressed: () => handleVote(Vote.down),
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