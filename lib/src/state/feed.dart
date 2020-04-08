import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Feed with ChangeNotifier {
  List<Post> _feed;

  List<Post> get posts => _feed;

  Future<bool> addPost(Post post) {
    _feed.add(post);
    notifyListeners();
    return Future.delayed(Duration(seconds: 2));
  }

  Future<bool> removePost(Post post) {
    _feed.remove(post);
    notifyListeners();
    return Future.delayed(Duration(seconds: 2));
  }

  // This should be called whenever there are updates for the user's feed
  // Then, when the user refreshes, we can serve new content immediately
  Future<bool> update() {
    _feed.removeAt(0);
    _feed.add(Post(userId: '123', content: 'update', time: 'time', score: 1));
    _feed.add(Post(userId: '456', content: 'update', time: 'time', score: 2));
//    notifyListeners();
    return Future.delayed(Duration(seconds: 2));
  }
}

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