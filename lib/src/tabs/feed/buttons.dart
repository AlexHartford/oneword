import 'package:flutter/material.dart';
import 'package:oneword/src/state/user.dart';
import 'package:provider/provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:oneword/src/state/feed.dart';
import 'package:oneword/src/state/post.dart';

class Buttons extends StatelessWidget {
  final PostModel post;

  Buttons({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      children: <Widget>[
        Votes(post: this.post),
        Comment(),
        Share()
      ],
    );
  }
}

class Votes extends HookWidget {
  final PostModel post;

  Votes({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserState>(context);
    final feed = Provider.of<FeedState>(context);

    final _dir = user.getDirectionForPost(this.post.id);

    _handleVote(Direction dir) {
      final adjustedDir = _dir == dir ? Direction.None : dir;
      user.addVote(this.post.id, adjustedDir);
      feed.votePost(this.post, adjustedDir);
    }

    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(
            FontAwesomeIcons.arrowAltCircleUp,
            color: _dir == Direction.Up ? Colors.blue : Colors.grey,
          ),
          onPressed: () => _handleVote(Direction.Up),
        ),
        Text(this.post.score.toString()),
        IconButton(
          icon: Icon(
            FontAwesomeIcons.arrowAltCircleDown,
            color: _dir == Direction.Down ? Colors.blue : Colors.grey,
          ),
          onPressed: () => _handleVote(Direction.Down),
        ),
      ],
    );
  }
}

class Comment extends HookWidget {
  Comment({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final commentCount = useState(420);

    return InkResponse(
      borderRadius: BorderRadius.circular(25),
      child: Row(
        children: <Widget>[
          const Icon(
            Icons.comment,
            color: Colors.blue,
          ),
          SizedBox(width: 5),
          Text(commentCount.value.toString())
        ],
      ),
      onTap: () {},
    );
  }
}

class Share extends StatelessWidget {
  Share({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.share),
      color: Colors.blue,
      onPressed: () {},
    );
  }
}