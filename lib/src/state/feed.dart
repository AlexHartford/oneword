import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:oneword/src/state/post.dart';
import 'package:oneword/src/state/user.dart';

class FeedState with ChangeNotifier {
  final String name;

  List<PostModel> _feed = List<PostModel>();

  FeedState({this.name = 'Nearby'}) {
    _feed.add(PostModel(userId: '0', username: 'Banana Polisher', content: 'mock', time: 'now', score: 69));
  }

  List<PostModel> get posts => _feed;

  Future<bool> addTextPost(String content) async {
    await Future.delayed(Duration(seconds: 1));

    _feed.add(
      PostModel(
        userId: UserState.instance.id,
        username: UserState.instance.name,
        content: content,
        time: DateFormat('h:mm a').format(DateTime.now()),
        score: 1
      )
    );
    notifyListeners();
    return true;
  }

  Future<bool> addPost(PostModel post) async {
    await Future.delayed(Duration(seconds: 2));
    _feed.add(post);
    notifyListeners();
    return true;
  }

  // TODO: Don't actually remove posts, just hide the content
  // Deleting posts could be an admin function from a separate app
  Future<bool> removePost(PostModel post) async {
    await Future.delayed(Duration(seconds: 2));
    _feed.remove(post);
    notifyListeners();
    return true;
  }

  Future<bool> votePost(PostModel post, Direction dir) async {
    _feed[_feed.indexOf(post)].vote(dir);
    notifyListeners();
    return true;
  }

  // This should be called whenever there are updates for the user's feed
  // Then, when the user refreshes, we can serve new content immediately
  Future<bool> update() async {
    await Future.delayed(Duration(seconds: 2));
    _feed.add(PostModel(userId: '123', username: 'Bill Gates', content: 'update', time: 'time', score: 1));
    _feed.add(PostModel(userId: '456', username: 'Bill', content: 'update', time: 'time', score: 2));
    return true;
  }

  Future<bool> refresh() async {
    await Future.delayed(Duration(seconds: 2));
    _feed.add(PostModel(userId: '123', username: 'Donald Trump', content: 'update', time: 'time', score: 1));
    _feed.add(PostModel(userId: '456', username: 'Donald Duck', content: 'update', time: 'time', score: 2));
    notifyListeners();
    return true;
  }
}