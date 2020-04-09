import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:oneword/src/state/user.dart';
import 'package:oneword/src/state/feed.dart';

import 'package:oneword/src/tabs/home/post.dart';

class Home extends StatelessWidget {
  static const route = '/home';

  Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final feed = Provider.of<Feed>(context);

    Future<bool> _refresh() async {
      return feed.refresh();
    }

    Post _mapPost(FeedItem post) {
      return Post(username: post.username, time: post.time, content: post.content);
    }

    _buildFeed() {
      return feed.posts.reversed.map((post) => _mapPost(post)).toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(feed.name),
        centerTitle: true,
        actions: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Row(
                children: <Widget>[
                  Icon(FontAwesomeIcons.bolt),
                  Text(
                    '${user.karma}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    ),
                  ),
                ],
              ),
          ))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: _buildFeed(),
        ),
      )
    );
  }
}
