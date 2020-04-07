import 'package:uuid/uuid.dart';

class Post {
  final String id = _generatePostId();
  final String userId;
  final String content;
  final String time;
  int score;

  Post({this.userId, this.content, this.time, this.score});

  static String _generatePostId() {
    return Uuid().v1();
  }

  void upVote() => this.score++;
  void downVote() => this.score--;
}