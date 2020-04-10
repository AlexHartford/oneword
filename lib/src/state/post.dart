import 'package:uuid/uuid.dart';

enum Direction { Up, Down, None }

class PostModel {
  final String id = _generatePostId();
  final String userId;
  final String username;
  final String content;
  final String time;
  int score;
  int _initScore;

  PostModel({this.userId, this.username, this.content, this.time, this.score}) {
    _initScore = score;
  }

  static String _generatePostId() {
    return Uuid().v1();
  }

  void vote(Direction dir) {
    switch (dir) {
      case Direction.Up:
        score = _initScore + 1;
        break;
      case Direction.Down:
        score = _initScore - 1;
        break;
      case Direction.None:
        score = _initScore;
        break;
    }
  }
}