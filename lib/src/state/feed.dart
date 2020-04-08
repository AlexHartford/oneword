import 'package:flutter/material.dart';
import 'package:oneword/src/state/user.dart';
import 'package:uuid/uuid.dart';

class Feed with ChangeNotifier {
  FeedItem mock = FeedItem(userId: '0', username: 'Banana Polisher', content: 'mock', time: 'now', score: 69);

  List<FeedItem> _feed = List<FeedItem>();

  Feed() {
    _feed.add(mock);
  }

  List<FeedItem> get posts => _feed;

  Future<bool> addTextPost(String content) {
    _feed.add(
      FeedItem(
        userId: User.instance.id,
        username: User.instance.name,
        content: content,
        time: '${DateTime.now().hour}: ${DateTime.now().minute}',
        score: 1
      )
    );
    notifyListeners();
    return Future.delayed(Duration(seconds: 2));
  }

  Future<bool> addPost(FeedItem post) {
    _feed.add(post);
    notifyListeners();
    return Future.delayed(Duration(seconds: 2));
  }

  Future<bool> removePost(FeedItem post) {
    _feed.remove(post);
    notifyListeners();
    return Future.delayed(Duration(seconds: 2));
  }

  // This should be called whenever there are updates for the user's feed
  // Then, when the user refreshes, we can serve new content immediately
  Future<bool> update() {
    _feed.removeAt(0);
    _feed.add(FeedItem(userId: '123', username: 'Donald Trump', content: 'update', time: 'time', score: 1));
    _feed.add(FeedItem(userId: '456', username: 'Donald Duck', content: 'update', time: 'time', score: 2));
//    notifyListeners();
    return Future.delayed(Duration(seconds: 2));
  }
}

class FeedItem {
  final String id = _generatePostId();
  final String userId;
  final String username;
  final String content;
  final String time;
  int score;

  FeedItem({this.userId, this.username, this.content, this.time, this.score});

  static String _generatePostId() {
    return Uuid().v1();
  }

  void upVote() => this.score++;
  void downVote() => this.score--;
}